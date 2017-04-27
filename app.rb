require 'sinatra'
require_relative 'hangman'

get '/' do
	erb :index
end

get '/load' do
	#not yet implemented
end

get '/start' do
	game = Hangman.new()
	redirect to('/game/guesser')
end

get 'game/guesser' do 
	guesses_left = game.guesses_left
	guessed_part = game.guessed_part
	guessed_letters = game.guessed_letters
	guess = params["guess"]
	erb :guesser_game, :locals => {:guesses_left => guesses_left, 
									:guessed_part => guessed_part}
end