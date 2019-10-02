class MusicLibraryController
  attr_accessor :path

  def initialize(path = "./db/mp3s")
    @path = path
    music_importer = MusicImporter.new(path)
    music_importer.import
  end

  def call
    loop do
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.chomp

      if input == "list songs"
        puts list_songs
      elsif input == "list artists"
        puts list_artists
      elsif input == "list genres"
        puts list_genres
      elsif input == "list artist"
        puts list_songs_by_artist
      elsif input == "list genre"
        puts list_songs_by_genre
      elsif input == "play song"
        puts play_song
      end

      if input == "exit"
        break
      end
    end
  end

  def list_songs
   counter = 0
   array = Song.all.sort_by {|song| song.name}
   array.uniq.each do |song|
     puts "#{counter += 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
   end
 end

  def list_artists
    counter = 0
    sorted = Artist.all.sort_by {|artist| artist.name}
    sorted.each do |artist|
      puts "#{counter += 1}. " + artist.name
    end
  end

  def list_genres
    counter = 0
    sorted = Genre.all.sort_by {|genre| genre.name}
    sorted.each do |genre|
      puts "#{counter += 1}. " + genre.name
    end
  end

  def list_songs_by_artist
    counter = 0
    puts "Please enter the name of an artist:"
    artist = gets.chomp

    if artist = Artist.find_by_name(artist)
      sorted = artist.songs.sort_by {|song| song.name}
      sorted.each do |song|
        puts "#{counter += 1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    counter = 0
    puts "Please enter the name of a genre:"
    genre = gets.chomp

    if genre = Genre.find_by_name(genre)
      sorted = genre.songs.sort_by {|song| song.name}
      sorted.each do |song|
        puts "#{counter += 1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp.to_i
    array = Song.all.uniq.sort_by {|song| song.name}
    if input <= array.count && input > 1
      song = array[input - 1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end

end