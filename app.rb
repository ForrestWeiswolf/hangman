require 'sinatra'
require_relative 'hangman'

get '/' do
	erb :index
end

get '/load' do
	#not yet implemented
end

get '/start' do
	GAME = Hangman.new()

	guesses_left = GAME.guesses_left
	guessed_part = GAME.guessed_part
	guessed_letters = GAME.guessed_letters

	erb :guesser_game, :locals => {:guesses_left => guesses_left, 
									:guessed_part => guessed_part, 
									:guessed_letters => guessed_letters}
end

get '/guesser_game' do 
	guess = params["guess"][/([A-Z]|[a-z])/].downcase
	if guess
		GAME.turn(guess)
	else
		redirect to('/game/guesser')
		#should display a message somehow
	end

	guesses_left = GAME.guesses_left
	guessed_part = GAME.guessed_part
	guessed_letters = GAME.guessed_letters

	erb :guesser_game, :locals => {:guesses_left => guesses_left, 
									:guessed_part => guessed_part, 
									:guessed_letters => guessed_letters}
end