require 'sinatra'
require 'erb'
require 'cgi'

$: << './lib'

require 'twitter.rb'
require 'picture.rb'
require 'misawa_magick.rb'

get '/' do
  erb :index
end

get '/write' do
  name = CGI.escapeHTML(params[:user_id])
  tweet_id = Twitter.new(params[:user_id]).random.tweet
  redirect "/#{name}/#{tweet_id}"
end

get '/image/:id' do
  content_type "image/jpeg"
  File.open("/tmp/#{params[:id]}", 'rb') { |f| f.read }
end

get '/:user/:id' do
  @name = CGI.escapeHTML(params[:user])
  @image_path = MisawaMagick.new(params[:id]).create
  erb :generate
end
