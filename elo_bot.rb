require_relative 'game'
require_relative 'leader'

class EloBot < SlackRubyBot::Bot
  command 'help' do |client, data, match|
    help = "Possible commands\n"
    help += "  leaderboard - show the current leaderboard\n"
    help += "  X lost to Y A-B - record a loss"
    help += "  taunt X - taunt some poor soul"
    help += "  challenge X - challenge a loser"
    client.say(text: help, channel: data.channel)
  end

  command 'leaderboard' do |client, data, match|
    leader = Leader.new
    client.say(text: leader.board, channel: data.channel)
  end

  command 'someone lost to another x-y', /.*lost to.*/ do |client, data, match|
    game = Game.new(match['command'])
    game.record
    client.say(channel: data.channel, text: game.congrats)
  end

  command 'taunt x', /.*taunt.*/ do |client, data, match|
    client.say(channel: data.channel, text: Elo::Giphy.random(tag: 'taunt'))
  end

  command 'challenge x', /.*challenge.*/ do |client, data, match|
    client.say(channel: data.channel, text: Elo::Giphy.random(tag: 'challenge'))
  end
end
