module ControllerMacros

  def set_referer
    before(:each) do
        request.env["HTTP_REFERER"] = "http://test.host/"
    end
  end

  def login_admin
    before(:each) do
      @user = create(:user, :admin)
      @session = { user_id: @user.id }
    end
  end

  def login_user
    before(:each) do
      @user = create(:user)
      @session = { user_id: @user.id }
    end
  end

  def login_disabled
    before(:each) do
      @user = create(:user, :disabled)
      @session = { user_id: @user.id }
    end
  end
end
