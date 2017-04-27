require "yaml"
require_relative 'player'

class Hangman
	attr_reader :guesses_left, :guessed_letters, :won
	def initialize(executioner = AIPlayer.new(), player = HumanPlayer.new())
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

	def turn
		input = @player.input(self.guessed_part)
		if input == "SAVE" 
			self.save
			self.turn
		else
			self.check_guess(input)
			self.display
		end
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

def start(player, ai)
	puts "Type 'LOAD' to load your saved game, G to start a game as the guesser, or \
		  E to start as the executioner."
	input = gets.chomp
	case input
	when 'LOAD'
		File.open('saves/save.yaml', 'r') do |file|
	    	game = YAML.load(file)
	    	puts "Game loaded."
	    	game.display
			game.gameloop
		end
	when 'E'
		game = Hangman.new(player, ai)
	when 'G'
		game = Hangman.new(ai, player)
	else
		puts "I didn't understand that."
		start(player, ai)
	end
end

start(HumanPlayer.new(), AIPlayer.new())