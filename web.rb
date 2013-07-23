require 'sinatra'
require 'erb'
require 'cgi'
require 'twitter'

$: << './lib'

require 'tweet.rb'
require 'picture.rb'
require 'misawa_magick.rb'


configure do
  Twitter.configure do |config|
    config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
    config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
    config.oauth_token = ENV['OAUTH_TOKEN']
    config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
  end
end

get '/' do
  erb :index
end

get '/write' do
  name = CGI.escapeHTML(params[:user_id])
  tweet_id = Tweet.new(params[:user_id]).random.tweet
  redirect "/#{name}/#{tweet_id}"
end

get '/image/:id' do
  content_type "image/jpeg"
  File.open("/tmp/#{params[:id]}", 'rb') { |f| f.read }
end

get '/:user/:id' do
  @name = CGI.escapeHTML(params[:user])
  @tweet = Tweet.status_id(params[:id])
  @image_path = MisawaMagick.new(@tweet).create
  @tweet = CGI.escapeHTML(@tweet)
  erb :generate
end
