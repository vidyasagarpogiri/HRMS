class WelcomeController < ApplicationController
  
  def index
    render :layout => false
  end
  
  def dashboard
   unless current_user.department == Department::HR
    @welcome_event = AmzurEvent.all.page(params[:page]).per(2)
    @welcome_announcements = Announcement.all.page(params[:page]).per(2)
    @welcome_recruitments = Recruitment.where(:status => "open").page(params[:page]).per(2)
    @employee = current_user.employee
    @reportee_employees = ReportingManager.where(:manager_id => @employee.id).map(&:employee)
    #TODO We have to find latest leave based on date . not by created at. #balaraju
    @latest_leave = @employee.leave_histories.where(:status => "APPROVED").order(created_at: :desc).first
   else
    redirect_to employees_path
   end
  end  
    
end
