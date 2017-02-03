class Player 
	def initialize
		@dictionary = File.readlines '5desk.txt'
		@dictionary = @dictionary.map { |e|  e.strip}
		@dictionary = @dictionary.select do |word|
			valid_word?(word)
		end
	end

	def valid_word?(word)
		(5..12).include?(word.size) && word[0] =~ /[a-z]/ \
	end
end

class HumanPlayer < Player
	def pick_word
		puts "Pick a word."
		word = gets.chomp.downcase
		if valid_word?(word) && @dictionary.include?(word)
			return word
		else
			puts "It should be a word, between 5 and 12 letters long."
			return self.pick_word
		end
	end

	def input(partial_word)
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
			return self.input(partial_word)
		end
	end
end

class AIPlayer < Player
	def initialize(guessed = [])
		@guessed = guessed
		super()
	end

	def pick_word
		return @dictionary.sample
	end

	def input(partial_word)
		possibilities = possible_words(partial_word).join()
		guess = nil
		rank = 0
		("a".."z").each do |l|
			count = possibilities.count(l)
			if count >= rank && !@guessed.include?(l)
				guess = l
				rank = count
			end
		end
		@guessed = @guessed + [guess]
		puts "I guess '#{guess}'"
		return guess
	end

	def possible_words(partial_word)
		partial_word = partial_word.gsub(/[_]/, '[a-z]')
		pattern = /^#{partial_word}$/
		#not sure that the ^ and $ are doing what I want them to
		#needs to check that word doesn't have guessed letters where they weren't shown, not just that it does where they were
		return @dictionary.select { |word| word =~ pattern}
	end
end

#ai = AIPlayer.new(["i", "n", "z", "h"])
#puts ai.input("in__n_i_i__")