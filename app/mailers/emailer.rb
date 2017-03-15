# frozen_string_literal: true
class Emailer < ActionMailer::Base
  default from: ENV.fetch('GMAIL_ADDRESS') { 'test@test.com' }

  def new_comment(user, comment)
    @user = user
    @comment = comment
    @commentable = @comment.commentable
    mail(to: @user.email, subject: "New Comment: #{@commentable.title.truncate(50)}")
  end

  def new_change(user, change)
    @user = user
    @change = change
    return false if user.enabled == false or user.banned == true
    mail(to: @user.email, subject: "New Change: #{@change.title.truncate(100)}")
  end

  def new_user(user, new_user)
    @user = user
    @new_user = new_user
    mail(to: @user.email, subject: "New User: #{@new_user.name_or_email}")
  end

  def account_enabled(user)
    @user = user
    mail(to: @user.email, subject: 'Picard Account Enabled')
  end

  def daily_alerts(email, certificates)
    @certificates = certificates
    mail(to: email, subject: "Picard Certificate Expirations - #{Date.today.strftime('%Y-%m-%d')}")
  end
end
