class WelcomeController < ApplicationController
  
  def index
    render :layout => false
  end
  
  def dashboard
  #raise params.inspect
   unless current_user.department == Department::HR
    @welcome_event = AmzurEvent.all.page(params[:page1]).per(2)
    @welcome_announcements = Announcement.all.page(params[:page2]).per(2)
    @welcome_recruitments = Recruitment.where(:status => "open").page(params[:page3]).per(2)
    @employee = current_user.employee

    @reportee_employees = ReportingManager.where(:manager_id => @employee.id).map(&:employee)
    #TODO We have to find latest leave based on date . not by created at. #balaraju
    #@latest_leave = @employee.leave_histories.where(:status => "APPROVED").order(created_at: :desc).first
    @latest_leave = @employee.leave_histories.where(status: "APPROVED")
    if EmployeeAttendence.last.present?
    last_week = EmployeeAttendence.last.log_date 
    
    @myattendence = EmployeeAttendence.where("log_date >? and log_date <= ?", last_week.beginning_of_week, last_week).count.to_s
    @sumofworkinghours = EmployeeAttendence.where("log_date >? and log_date <= ?", last_week.beginning_of_week, last_week).map(&:total_working_hours).sum
    @avg = @sumofworkinghours/5
    end
   else
    redirect_to employees_path
   end
  end  
    
end
