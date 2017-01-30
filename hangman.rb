require "yaml"
require_relative 'player'

class Hangman
	def initialize(executioner, player)
		@executioner, @player = executioner, player
		@word = executioner.pick_word
		@guesses_left = 6
		@guessed_letters = []
		
		@won = false

		self.gameloop
	end

	def gameloop
		while @guesses_left > 0
			self.turn()
		end

		self.end_game
	end

	def display
		puts "Guesses left: #{@guesses_left}"
		puts self.guessed_part
		print "\n"
	end

	def guessed_part
		result = ""
		@word.each_char do |letter|
			if @guessed_letters.include?(letter)
				result = result + letter
			else
				result = result + "_"
			end
		end
		return result
	end

	def turn
		input = @player.input
		if input == "SAVE" 
			self.save
			self.turn
		else
			self.check_guess(input)
			self.display
		end
	end

	def check_guess(guess)
		@guessed_letters.push(guess)
		@guesses_left -= 1 unless @word.include?(guess)
		@won = @word.split("").all? { |letter| @guessed_letters.include?(letter)}
		@guesses_left = 0 if @won
	end

	def end_game
		if @won
			puts "Yes! The word was '#{@word}', and the convict has been rescued."
		else
			puts "The word was '#{@word}', but it's too late! The hanged man dies."
		end
	end

	def save
		Dir.mkdir('saves') unless Dir.exist? "saves"
		File.open('saves/save.yaml', 'w') do |file|
    		file.puts YAML.dump(self)
		end
		puts "Game saved."
	end
end

ai = AIPlayer.new()
player = HumanPlayer.new()
puts "Type 'LOAD' to load your saved game, or type anything else to start a new game."
input = gets.chomp
if input == 'LOAD'
	File.open('saves/save.yaml', 'r') do |file|
    	game = YAML.load(file)
    	puts "Game loaded."
    	game.display
		game.gameloop
	end
else
	game = Hangman.new(ai, player)
end