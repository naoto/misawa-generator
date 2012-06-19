module Picture
  
  def self.random
    Dir.glob('template/*').sample
  end

end
