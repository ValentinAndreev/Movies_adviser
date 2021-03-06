# frozen_string_literal: true

# Google oauth authentication controller
class CallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])
    @user.username = @user.email
    @user.save
    sign_in_and_redirect @user
  end
end
