require "rails_helper"

RSpec.describe Emailer, type: :mailer do

  include RSpecHtmlMatchers

  describe '#new_comment' do
    let(:user) { create(:user) }
    let(:change) { create(:engineering_change) }
    let(:comment) { create(:comment, user: user, commentable: change) }
    let(:mail) { Emailer.new_comment(user, comment) }

    it 'sets the subject' do
      expect(mail.subject).to match(/New Comment/)
    end

    it 'sets the to: email address' do
      expect(mail.to).to eq([user.email])
    end

    describe 'email body' do
      subject { mail.body.encoded }
      it { is_expected.to have_content(user.name_or_email) }
      it { is_expected.to have_content(comment.user.name_or_email) }
      it { is_expected.to have_content(comment.comment) }
      it { is_expected.to have_tag(:a, href: polymorphic_url(change)) }
    end
  end

  describe '#new_change' do
    let(:user) { create(:user) }
    let(:change) { create(:engineering_change) }
    let(:mail) { Emailer.new_change(user, change) }

    it 'sets the subject' do
      expect(mail.subject).to match(/New Change/)
    end

    it 'sets the to: email address' do
      expect(mail.to).to eq([user.email])
    end

    describe 'email body' do
      subject { mail.body.encoded }
      it { is_expected.to have_content(user.name_or_email) }
      it { is_expected.to have_content(change.title) }
      it { is_expected.to have_content(change.poc.name_or_email) }
      it { is_expected.to have_content(change.when) }
      it { is_expected.to have_content(change.environment.name) }
      it { is_expected.to have_content(change.tags_csv) }
      it { is_expected.to have_content(change.description) }
      it { is_expected.to have_tag(:a, href: engineering_change_url(change)) }
    end
  end

  describe '#new_user' do
    let(:admin) { create(:user, :admin) }
    let(:user) { create(:user) }
    let(:mail) { Emailer.new_user(admin, user) }

    it 'sets the subject' do
      expect(mail.subject).to match(/New User/)
    end

    it 'sets the to: email address' do
      expect(mail.to).to eq([admin.email])
    end

    describe 'email body' do
      subject { mail.body.encoded }
      it { is_expected.to have_content(user.email) }
      it { is_expected.to have_content(user.name) }
      it { is_expected.to have_tag(:a, href: user_path(user)) }
      it { is_expected.to have_tag(:a, href: user_enable_url(user)) }
    end
  end

  describe '#account_enabled' do
    let(:user) { create(:user) }
    let(:mail) { Emailer.account_enabled(user) }

    it 'sets the subject' do
      expect(mail.subject).to match(/Picard Account Enabled/)
    end

    it 'sets the to: email address' do
      expect(mail.to).to match([user.email])
    end

    it 'provides a link to Picard' do
      expect(mail.body.encoded).to have_tag(:a, href: root_url)
    end
  end

  #describe '#daily_alerts' do
  #  let(:user) { create(:user) }
    #let(:mail) { Emailer.daily_alerts(user.email, @certificates) }

  #  before do
  #    @certificates = [create(:certificate), create(:certificate, :test2)]
  #    @mail = Emailer.daily_alerts(user.email, @certificates)
  #  end

  #  it 'sets the subject' do
  #    expect(@mail.subject).to match(/Picard Certificate Expirations/)
  #  end

  #  it 'sets the to: email address' do
  #    expect(@mail.to).to match([user.email])
  #  end

  #  describe 'email body' do
  #    subject { @mail.body.encoded }
  #    @certificates.each do |cert|
  #      it { is_expected.to have_content(cert.cn) }
  #    end
  #  end
  #end
end
