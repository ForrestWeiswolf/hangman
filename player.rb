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
		puts "Guess a letter."
		input = gets.chomp
		guess = input[(/([A-Z]|[a-z])/)]
		puts guess
		return guess
	end
end

class AIPlayer < Player
	def pick_word
		dictionary = File.readlines '5desk.txt'
		dictionary.map { |e|  e.strip}
		dictionary = dictionary.select { |word|  (5..12).include?(word.size) && word[0] =~ /[a-z]/}
		#select there should maybe take a proc
		puts dictionary[0..30]
		return dictionary.sample.strip
	end
end