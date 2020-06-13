require 'pry'
class Artist

    extend Concerns::Findable

    attr_accessor :name, :songs

    @@all = []

    def initialize(name)
        self.name = name
        self.songs = []
        save
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.create(name)
        artist = self.new(name)
        artist.save
        artist
    end

    def self.destroy_all
        self.all.clear
    end

    def add_song(song)
        song.artist = self unless song.artist != nil
        self.songs << song unless self.songs.include?(song)
    end

    def genres
        @songs.map{|song| song.genre if song.artist == self}.uniq
    end
  
end

