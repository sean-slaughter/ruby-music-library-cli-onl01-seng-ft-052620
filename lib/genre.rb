class Genre
    extend Concerns::Findable
    
    attr_accessor :name, :songs

    @@all = []

    def initialize(name)
        self.name = name
        self.songs = []
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.create(name)
        genre = self.new(name)
        genre.save
        genre
    end

    def self.destroy_all
        self.all.clear
    end

    def add_song(song)
        song.genre = self unless song.genre != nil
        self.songs << song unless self.songs.include?(song)
    end

    def artists
        @songs.map{|song| song.artist if song.genre == self}.uniq
    end

end