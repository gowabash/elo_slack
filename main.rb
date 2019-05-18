require 'slack-ruby-bot'

class PongBot < SlackRubyBot::Bot
  command 'leaders' do |client, data, match|
    client.say(text: 'Matt is winnig, of course', channel: data.channel)
  end
end

PongBot.run
