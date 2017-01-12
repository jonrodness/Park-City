class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :flash => { :notice => "Your password is #{@user.password}. Please record this somewhere. Thank you. "}
    else
     session["devise.user_attributes"] = @user.attributes
     redirect_to new_user_registration_url, :flash => { :notice => "Your password is #{@user.password}. Please record this somewhere. Thank you. "}
     
   end
 end
end
