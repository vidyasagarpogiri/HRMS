class WelcomeController < ApplicationController
  
  def index
    render :layout => false
  end
  
  def dashboard
   unless current_user.department == Department::HR
    @welcome_event = AmzurEvent.all
    @welcome_announcements = Announcement.all
    @welcome_recruitments = Recruitment.where(:status => "open")
    @employee = current_user.employee
   else
    redirect_to employees_path
   end
  end
  
  

end
