#-*- coding: utf-8 -*-

require 'open-uri'
require 'nokogiri'

class Twitter

  def initialize(user)
    @user = user.gsub(/^@/,'')
 
    url = "http://twitter.com/statuses/user_timeline/#{user}.rss"
    html = Nokogiri::HTML(open(url))
    @twit = html.search("item/title").to_a
  rescue => e
    @twit = []
  end

  def random
    @twit.shuffle!
    self
  end

  def tweet
    @twit.first.content.gsub(/^.+?:\s/,"")
  rescue => e
    "エラー"
  end

end
