require_relative 'player'

class Hangman
	def initialize(executioner, player)
		@executioner, @player = executioner, player
		@word = executioner.pick_word
		@guesses_left = 6
		@guessed_letters = []
		
		@won = false
		
		while @guesses_left > 0
			turn()
			if @word.split("").all? { |letter| @guessed_letters.include?(letter)}
				@won = true 
				break
			end
		end

		self.end_game
	end

	def display
		puts "Guesses left: #{@guesses_left}"
		@word.each_char do |letter|
			if @guessed_letters.include?(letter)
				print letter
			else
				print "_"
			end
		end
		print "\n"
	end

	def turn
		guess = @player.guess
		@guessed_letters.push(guess)
		@guesses_left -= 1 unless @word.include?(guess)
		self.display
	end

	def end_game
		if @won
			puts "Yes! The word was '#{@word}', and the convict has been rescued."
		else
			puts "The word was '#{@word}', but it's too late! The hanged man dies."
		end
	end
end

exa = AIPlayer.new()
gus = HumanPlayer.new()
hang = Hangman.new(exa, gus)
hang.display