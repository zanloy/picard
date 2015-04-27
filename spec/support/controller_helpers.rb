module ControllerHelpers
  def sign_in (admin = false)
    session[:user_id] = admin ? 1 : 2
  end

  def sign_out
    session[:user_id] = nil
  end
end
