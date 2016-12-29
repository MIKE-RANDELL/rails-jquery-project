class CallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    #binding.pry
    sign_in @user
    redirect_to root_path
  end
end
