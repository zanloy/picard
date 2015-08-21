class AdminController < ApplicationController

  authorize_resource class: false

  def index
    @enabled_users = User.enabled.sorted
    @disabled_users = User.all.disabled
    @banned_users = User.banned.sorted
  end

end
