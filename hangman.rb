require_relative 'player'

class Hangman
	def initialize(executioner, player)
		@executioner, @player = executioner, player
		@word = executioner.pick_word
		puts @word
		@guesses_left = 6
		@guessed_letters = []

		while @guesses_left > 0
			turn()
		end
	end

	def display()
		puts "Guesses left: #{@guesses_left}"
		@word.each_char do |letter|
			if @guessed_letters.include?(letter.downcase)
				print letter
			else
				print "_"
			end
		end
		print "\n"
	end

	def turn
		guess = @player.guess #I really need to rename something here
		@guessed_letters.push(guess)
		@guesses_left -= 1 unless @word.include?(guess)
		self.display
	end
end

exa = AIPlayer.new()
gus = HumanPlayer.new()
hang = Hangman.new(exa, gus)
hang.display