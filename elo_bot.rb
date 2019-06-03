require_relative 'game'

class EloBot < SlackRubyBot::Bot
  command 'leaders' do |client, data, match|
    client.say(text: 'Matt is winnig, of course', channel: data.channel)
  end

  # seth lost to <@U2X8RDUD8> 4-3
  command 'someone lost to another x-y', /.*lost to.*/ do |client, data, match|
    game = Game.new(match['command'])
    game.record
    client.say(channel: data.channel, text: game.congrats)
  end
end
