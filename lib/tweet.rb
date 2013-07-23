#-*- coding: utf-8 -*-

require 'open-uri'
require 'nokogiri'

class Tweet

  def initialize(user)
    @user = user.gsub(/^@/,'')
    @twit = Twitter.user_timeline(user).to_a
  rescue
    @twit = []
  end

  def random
    @twit.shuffle!
    self
  end

  def tweet
    @twit.first.content.gsub(/^.+\/(\d+)$/,'\\1')
  rescue => e
    "エラー: #{e}"
  end

  def self.status_id(id)
    Twitter.status(id)
  rescue => e
    "エラー: #{e}"
  end

end