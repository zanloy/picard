class ProfilesController < ApplicationController
  def index
    @users = User.enabled.sorted
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end
end
