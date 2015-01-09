class OmniauthCallbacksController < ApplicationController
      
    
  def all
    email = request.env["omniauth.auth"]["info"]["email"]
    @user1 = User.find_by_email(email)
    if request.env["omniauth.auth"]["extra"]["raw_info"]["hd"] == "amzur.com"
      if @user1.present? && @user1.employee.present?
        @user = User.from_omniauth(request.env["omniauth.auth"])
        @user1.provider = @user.provider 
        @user1.uid = @user.uid 
        @user1.token= @user.token
        @user1.secret=  @user.secret
        @user1.save!
        @user = @user1
        if @user.persisted?
          session["oauth"] = request.env["omniauth.auth"]["info"]
          flash.notice = "Signed in!"
          sign_in_and_redirect @user
        else
          session["devise.user_attributes"] = user.attributes
          redirect_to root_path
        end
           
      else
        render :text => "You Dont have permission to access Please Contact HR"
      end
    else
       render :text => "Sign Out from your gmail address and Login with Amzur Mail "
    end
  end
  alias_method :google_oauth2, :all
  
 
  
  
end
