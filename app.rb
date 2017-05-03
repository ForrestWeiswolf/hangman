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

	guessed_part = GAME.guessed_part
	guessed_letters = GAME.guessed_letters

	erb :guesser_game, :locals => {:hangman_img => "<img src='/hangman0.png'>", 
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

	if GAME.won
		erb :win
	elsif GAME.guesses_left <= 0
		erb :lose, :locals => {:word => GAME.word}
	else
		hangman_img = "<img src='/hangman#{6-GAME.guesses_left}.png'>"
		guessed_part = GAME.guessed_part
		guessed_letters = GAME.guessed_letters

		erb :guesser_game, :locals => {:hangman_img => hangman_img, 
									:guessed_part => guessed_part, 
									:guessed_letters => guessed_letters}
	end
end