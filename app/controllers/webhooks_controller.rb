class WebhooksController < ApplicationController

  skip_before_filter :store_path, :require_login
  skip_before_action :verify_authenticity_token

  before_filter :validate_token, only: :slack

  def slack
    payload = slack_params
    logger.debug "WebhooksController#slack :: payload = #{payload.inspect}"
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
        render text: {text: 'No matching username in database. Please add your Slack username to your profile and retry.'}.to_json
        return
      end
      change = EngineeringChange.create(entered_by: user, poc: user, environment: Environment.first, title: body)
      if change.save
        response = {text: 'Success!'}
      else
        response = {text: 'Failed.'}
      end
    when 'list'
      changes = EngineeringChange.timeline.limit(5)
      response_body = ''
      changes.each do |change|
        response_body += "#{change.when.strftime('%D @ %I:%M %p')} : <#{engineering_change_url(change)}|#{change.title}>\n"
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

  def validate_token
    return if Rails.env.test?
    unless ENV['SLACK_TOKENS'].split(',').include? params[:token]
      render text: {text: 'Bad or missing token.'}.to_json
    end
  end

  def slack_params
    params.permit(:token, :user_name, :text, :trigger_word)
  end

end
