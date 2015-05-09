require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe '#flash_class' do
    it 'responds to :notice' do
      expect(helper.flash_class(:notice)).to eq 'alert alert-info'
    end
    it 'responds to :success' do
      expect(helper.flash_class(:success)).to eq 'alert alert-success'
    end
    it 'responds to :error' do
      expect(helper.flash_class(:error)).to eq 'alert alert-error'
    end
    it 'responds to :alert' do
      expect(helper.flash_class(:alert)).to eq 'alert alert-error'
    end
  end

  describe '#linkify_tags' do
    it 'linkifies the fucking tags' do
      title = 'This is a #test title with an #embedded tag.'
      expect(helper.linkify_tags(title)).to have_link('#test', href: tag_path('test'))
      expect(helper.linkify_tags(title)).to have_link('#embedded', href: tag_path('embedded'))
    end
  end
end
