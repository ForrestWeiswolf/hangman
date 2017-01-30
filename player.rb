class Player 
	def initialize
	end
end

class HumanPlayer < Player
	def pick_word
		word = gets.chomp
		return word
		#need to check that it's a valid word, etc.
	end

	def input
		puts "Guess a letter, or type 'SAVE'."
		input = gets.chomp
		if input == "SAVE" 
			return input
		else
			input = input[(/([A-Z]|[a-z])/)]
		end

		if input
			return input.downcase
		else
			puts "That wasn't a valid guess."
			return self.input
		end
	end
end

class AIPlayer < Player
	def initialize
		@dictionary = File.readlines '5desk.txt'
		@dictionary = @dictionary.map { |e|  e.strip}
		@dictionary = @dictionary.select { |word|  (5..12).include?(word.size) && word[0] =~ /[a-z]/}
	end

	def pick_word
		return @dictionary.sample
	end
end