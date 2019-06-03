require 'json'

module Elo
  class Player
    attr_accessor :name

    def save
      file = File.open "#{name}.elo", "w+"
      data = {rating: @rating, games_played: @games_played}
      file.puts data.to_json
      file.close 
    end

    def self.load(name)
      filename = "#{name}.elo"
      if File.file?(filename)
        file = File.open filename, "r"
        data = JSON.load file
        file.close 
      else
        data = {}
      end

      me = Elo::Player.new(rating: data['rating'] || 1000, games_played: data['games_played'] || 0)
      me.name = name
      me
    end
  end
end
