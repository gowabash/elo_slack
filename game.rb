require_relative 'elo/player'

class Game
  COMMAND_REGEX = /<(.*)> lost to <(.*)>\s*(\d+)\s*-\s*(\d+)/
  attr_reader :winner, :loser, :score1, :score2

  def initialize(command)
    parse_command(command)
    flip if @score1 < @score2
  end

  def record
    @winner.wins_from(@loser)
    save
  end

  def congrats
    "Gret job <#{@winner.name}>!  Better luck next time <#{@loser.name}>"
  end

  private

  def save
    File.open("games.txt", "a+") do |file|
      file.puts({winner: @winner.name, loser: @loser.name, score: "#{@score1} - #{@score2}"}.to_json)
    end
    @winner.save
    @loser.save
  end

  def calculate
    loser_score = File.read("{@loser}.elo")
    wp.wins_f
  end

  def parse_command(command)
    m = command.match COMMAND_REGEX
    pp m
    @loser = Elo::Player.load(m[1])
    @winner = Elo::Player.load(m[2])
    @score1 = m[3].to_i
    @score2 = m[4].to_i
  end

  def flip
    temp = @score1
    @score1 = @score2
    @score2 = temp
  end
end
