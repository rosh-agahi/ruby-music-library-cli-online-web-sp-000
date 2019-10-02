class Song
  attr_accessor :name
  attr_reader :genre, :artist 
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist 
    self.genre = genre if genre
  end
  
  def save
    @@all << self
  end 
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    self.all.clear
  end

  def self.create (name)
    song = self.new(name)
    song.save
    song
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre= (genre)
    @genre = genre
    genre.songs << self if !genre.songs.include?(self)
  end
  
  def self.find_by_name (name)
    all.find {|song| song.name == name}
  end
  
  def self.find_or_create_by_name (name)
    self.find_by_name(name) || self.create(name)
  end
  
  def self.new_from_filename (file)
    name = file.split(" - ")[1]
    artist_name = file.split(" - ")[0]
    genre_name = file.split(" - ")[2].chomp(".mp3")
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    song = self.new(name, artist, genre)
  end

  def self.create_from_filename (file)
    song = self.new_from_filename(file)
    song.save
  end
  
end
