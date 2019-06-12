require_relative 'game'
require_relative 'leader'

class EloBot < SlackRubyBot::Bot
  command 'help' do |client, data, match|

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

end
