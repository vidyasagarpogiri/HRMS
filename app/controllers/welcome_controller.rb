class WelcomeController < ApplicationController
  
  def index
    render :layout => false
  end
  
  def dashboard
    @welcome_event = AmzurEvent.all
    @welcome_announcements = Announcement.all
    @welcome_recruitments = Recruitment.where(:status => "open")
    @employee = current_user.employee
    
  end
  
  

end
