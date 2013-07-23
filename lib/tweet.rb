#-*- coding: utf-8 -*-

require 'open-uri'
require 'nokogiri'

class Tweet

  def initialize(user)
    @user = user.gsub(/^@/,'')
    @twit = Twitter.user_timeline(user).map { |x| x.id }
  rescue
    @twit = []
  end

  def random
    @twit.shuffle!
    self
  end

  def tweet
    @twit.first
  rescue => e
    "エラー: #{e}"
  end

  def self.status_id(id)
    Twitter.status(id)
  rescue => e
    "エラー: #{e}"
  end

end
