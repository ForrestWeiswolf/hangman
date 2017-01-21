class Hangman
	def initialize
		dictionary = File.readlines '5desk.txt'
		dictionary = dictionary.select { |e|  e.length.between?(5, 12)}
		@word = dictionary.sample.strip
		@guesses_left = 6
		@guessed_letters = []
		puts @word
	end

	def display()
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
end

hang = Hangman.new()
hang.display