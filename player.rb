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

	def guess
		puts "Guess a letter, or type 'SAVE' or 'LOAD'."
		input = gets.chomp
		if input == "SAVE" || input == "LOAD"
			return input
		else
			guess = input[(/([A-Z]|[a-z])/)].downcase
			puts guess
			return guess
		end
	end
end

class AIPlayer < Player
	def pick_word
		dictionary = File.readlines '5desk.txt'
		dictionary.map { |e|  e.strip}
		dictionary = dictionary.select { |word|  (5..12).include?(word.size) && word[0] =~ /[a-z]/}
		#select there should maybe take a proc
		return dictionary.sample.strip
	end
end