class OmniauthCallbacksController<Controller                                                                                            
      
    def all              
      @user = User.from_omniauth(request.env["omniauth.auth"])
      @user1 = User.find_by_email(@user.email)
    if @user1.sign_in_count == 0                          
      @user1.provider = @user.provider 
      @user1.uid = @user.uid                                
      @user1.token= @user.token         
      @user1.secret=  @user.secret
      @user1.save!
      @user = @user1  
    end                            
                                     other_emp_view   
    if request.env["omniauth.auth"]["extra"]["raw_info"]["hd"] == "amzur.com"  
      if @user.persisted?
      
        session["oauth"] = request.env["omniauth.auth"]["info"]
        flash.notice = "Signed in!"
          
       
        sign_in_and_redirect @user
      else
        session["devise.user_attributes"] = user.attributes
        redirect_to root_path
      end
    else
      flash[:notice]= "Not an amzur mail"
      redirect_to root_path
    end
  end                   
  alias_method :google_oauth2, :all
                
                                                                                           
end                 
                          
             
          
