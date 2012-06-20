# -*- encoding: utf-8

require 'rubygems'
require 'RMagick'

class MisawaMagick

  FONT = "./font/sazanami-gothic.ttf"
  MISAWA_DIR = "/tmp/"

  def initialize(tweet)
    @poss_y = [290, 270, 250, 230, 210, 190, 170, 150, 130, 110, 90, 70, 50, 30]
    @poss_x = [90, 70, 50, -70, -90]
    @tweet = tweet
  end
  
  def create
    pict = Picture.random
    make(pict, @tweet)
  end

  def make(image, text)
    img = Magick::ImageList.new("#{image}")

    parse(text).each_with_index { |line, line_index|
      line.split(//).each_with_index { |word, word_index|
        annotate(img, @poss_x[line_index], @poss_y[word_index], word)
      }
    }
    file_name = "#{Time.now.to_i}.jpg"
    img.write("#{MISAWA_DIR}#{file_name}")
    file_name
  end

  def annotate(img, x, y, text)
    reg = /([。、ー・〜])/
    m_text = Magick::Draw.new
    
    if reg =~ text
      x = x + 8
      y = y + 10
    end
    m_text.annotate(img, 0, 0, x, y, text) {
      self.gravity = Magick::SouthGravity
      self.pointsize = 20
      self.fill = '#000000'
      self.font = FONT
      self.font_weight = Magick::BoldWeight
      self.rotation = 270 if reg =~ text
    }
  end

  def parse(text)

    tmp = ""
    lines = []

    text.split(//).each do |word|
      tmp << word
      if tmp.split(//).size == @poss_y.size
        lines << tmp
        tmp = ""
        break if lines.join.split(//).size == @poss_x.size * @poss_y.size
      end

    end
    
    lines << tmp if !tmp.empty?
    lines
  end
end
