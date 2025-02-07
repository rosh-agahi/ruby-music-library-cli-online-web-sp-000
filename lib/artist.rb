class Artist

  extend Concerns::Findable

  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end

  def add_song(song)
    if song.artist != self
      song.artist = self
    end
    self.songs << song unless self.songs.include?(song)
   end

  def genres
    self.songs.collect {|g| g.genre}.uniq
  end

end