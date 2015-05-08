class WebhooksController < ApplicationController

  skip_before_action :verify_authenticity_token

  def slack
    token = 'eKLjCtS6I102bLvvjPV0RYXt'
    payload = slack_params
    action = payload.split.first
    case action
    when 'add'
      change = EngineeringChange.create {title: payload.text, when: Time.zone.now}
      if change.save
        response = {text: 'Success!'}
      else
        response = {text: 'Failed.'}
      end
    end
    if response
      render text: response.to_json
    else
      render body: nocontent
    end
  end

  private

  def slack_params
    params.permit(:token, :user_name, :text)
  end

end
