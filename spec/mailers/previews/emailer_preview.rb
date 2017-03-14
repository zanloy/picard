# frozen_string_literal: true
# Preview all emails at http://localhost:3000/rails/mailers/emailer
class EmailerPreview < ActionMailer::Preview
  def new_change
    user = User.first
    change = EngineeringChange.first
    Emailer.new_change(user, change)
  end
end
