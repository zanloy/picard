module Features
  module SessionHelpers
    def sign_up_with(email, password)
      visit signup_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_on 'Create Account'
    end

    def sign_in(admin = false)
      before(:each) do
        if admin
          @user = create(:user, :admin, new_password: '1qazxsw2#EDCVFR$')
        else
          @user = create(:user, new_password: '1qazxsw2#EDCVFR$')
        end
        visit signin_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: '1qazxsw2#EDCVFR$'
        click_on 'Sign in'
      end
    end
  end
end
