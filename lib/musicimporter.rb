class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    Dir.entries(path).delete_if { |file| file == "." || file == ".." }
  end

  def import
    files.each {|filename| Song.create_from_filename(filename)}
  end

end