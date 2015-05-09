class WebhooksController < ApplicationController

  skip_before_filter :store_path, :require_login
  skip_before_action :verify_authenticity_token

  def slack
    token = 'eKLjCtS6I102bLvvjPV0RYXt'
    payload = slack_params
    logger.debug "WebhooksController#slack :: payload = #{payload.inspect}"
    unless payload[:token] == token
      render text: {text: 'Bad or missing token.'}.to_json
      return
    end
    unless payload[:trigger_word] == 'picard'
      render text: {text: 'Bad trigger word.'}.to_json
      return
    end
    words = payload[:text].split
    trigger_word = words.shift
    action = words.shift
    body = words.join(' ') unless words.empty?
    case action
    when 'add'
      if profile = Profile.find_by_slack_username(payload[:user_name])
        user = profile.user
      else
        render text: {text: 'No matching username in database.'}.to_json
        return
      end
      change = EngineeringChange.create({entered_by: user, poc: user, title: body, :when => Time.zone.now})
      if change.save
        response = {text: 'Success!'}
      else
        response = {text: 'Failed.'}
      end
    when 'list'
      changes = EngineeringChange.timeline.limit(5)
      response_body = ''
      changes.each do |change|
        response_body += "<#{engineering_change_url(change)}|#{change.title}>\n"
      end
      response = {text: response_body}
    end
    if response
      render text: response.to_json
    else
      head :no_content
    end
  end

  private

  def slack_params
    params.permit(:token, :user_name, :text, :trigger_word)
  end

end
