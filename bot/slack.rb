SlackRubyBot::Client.logger.level = Logger::INFO

class PicardSlackBot < SlackRubyBot::Bot
  command 'latest' do |client, data, match|
    changes = EngineeringChange.timeline.limit(5)
    #mapped = changes.map { |change| "#{Rails.application.views.url_helpers.link_to(change.title, Rails.application.routes.url_helpers.engineering_change_url(change))} by #{change.entered_by.name}" }
    mapped = changes.map { |change| "#{change.title} by #{change.entered_by.name}" }
    client.say(channel: data.channel, text: mapped.join("\n"))
  end
end
