#-*- coding: utf-8 -*-

require 'open-uri'
require 'nokogiri'

class Twitter

  def initialize(user)
    @user = user.gsub(/^@/,'')
 
    url = "http://twitter.com/statuses/user_timeline/#{user}.rss"
    html = Nokogiri::HTML(open(url))
    @twit = html.search("item/guid").to_a
  rescue => e
    @twit = []
  end

  def random
    @twit.shuffle!
    self
  end

  def tweet
    @twit.first.content.gsub(/^.+\/(\d+)$/,'\\1')
  rescue => e
    "エラー"
  end

  def self.status_id(id)
    Nokogiri::HTML(open("http://api.twitter.com/1/statuses/show/#{id}.xml")).at("status/text").content.gsub(/^.+?:\s/,"")
  rescue => e
    "エラー: #{e}"
  end

end
