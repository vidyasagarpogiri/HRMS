class WelcomeController < ApplicationController
  
  def index
    render :layout => false
  end
  
  def dashboard
   unless current_user.department == Department::HR
    @welcome_event = AmzurEvent.all.page(params[:page1]).per(2)
    @welcome_announcements = Announcement.all.page(params[:page2]).per(2)
    @welcome_recruitments = Recruitment.where(:status => "open").page(params[:page3]).per(2)
    @employee = current_user.employee
   else
    redirect_to employees_path
   end
  end  
    
end
