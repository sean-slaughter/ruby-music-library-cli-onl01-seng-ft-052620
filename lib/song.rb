require "pry"
class Song

    extend Concerns::Findable

    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        self.name = name
        self.artist=(artist) unless artist.nil?
        self.genre=(genre) unless genre.nil?
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.create(name)
        song = self.new(name)
        song.save
        song
    end

    def self.destroy_all
        self.all.clear
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.new_from_filename(file_name)
       file = file_name.split(" - ")
       song = self.create(file[1])
       song.artist=(Artist.find_or_create_by_name(file[0]))
       song.genre=(Genre.find_or_create_by_name(file[2].gsub(".mp3", "")))
       song
    end

    def self.create_from_filename(file_name)
        song = Song.new_from_filename(file_name)
        song.save
        song
    end
end