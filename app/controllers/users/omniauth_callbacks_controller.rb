class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook

    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
     # set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?

     # sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated

     # sign_in(@user)


     # Close FB window after login http://bit.ly/1bytbC4
     sign_in @user, :event => :authentication 
    render :text => '<script type="text/javascript"> window.opener.location.reload(true); </script><script type="text/javascript"> window.close(); </script>'


      # @after_sign_in_url = after_sign_in_path_for(@user) 
      # render '/views/sessions/callback.html.erb', :layout => false
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end

