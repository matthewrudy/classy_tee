class CreateContent < ActiveRecord::Migration
  def self.up
    create_table :content do |t|
      t.string :title
    end
  end

  def self.down
    drop_table :content
  end
end

class CreateMP3ContentExtensions < ActiveRecord::Migration
  def self.up
    create_table :mp3_content_extensions do |t|
      t.string :mp3_url
    end
  end

  def self.down
    drop_table :content
  end
end

class Content < ActiveRecord::Base
end

class MP3Content < Content
  classy_tee!
end

class MP3ContentExtensions < ActiveRecord::Base
end

Content.new(:title => "Some normal content")
MP3Content.new(:title => "An mp3 of some sort", :mp3_url => "http://mp3.com/an/example.mp3") # :mp3_url works like an attribute, lazily saved

mp3 = MP3Content.create!(:title => "an mp3 saved")
mp3.mp3_url = "some new url" # this hasn't been saved yet
mp3.save # this will now be saved!

mp3.reload!
mp3.mp3_url == "some new url"

MP3Content.find(:all) # will eager load the associations thanks to Rails 2.3's lovely :default_scope method!