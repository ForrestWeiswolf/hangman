require 'sinatra'

get '/' do
	erb :index
end

get '/load' do
	#not yet implemented
end

get '/start' do
	erb :start
end

get 'start/guesser' do 
end

get 'start/executioner' do 
end