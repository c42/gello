class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def failure
    set_flash_message :alert, :failure, :kind => OmniAuth::Utils.camelize(failed_strategy.name), :reason => failure_message
    redirect_to :root
  end
  
  def github
    user = User.find_or_create_from_oauth(request.env["omniauth.auth"])    
    
    if user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Github"
      sign_in_and_redirect user, :event => :authentication
      session["devise.github_access_token"] = request.env["omniauth.auth"].credentials.token
    else
      flash[:alert] = "Github authentication succeeded, but local account creation failed!"
      redirect_to root_path
    end
  end
end