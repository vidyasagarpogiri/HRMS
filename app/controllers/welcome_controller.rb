class WelcomeController < ApplicationController
  
  #layout "wall_layout", only: [:wall]
  
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
    @welcome_albums = Album.all.order('created_at DESC').page(params[:page4]).per(1)   
    @photos = Photo.all
    #raise @photos .inspect
    
    
    @reportee_employees = ReportingManager.where(:manager_id => @employee.id).map(&:employee)
    #TODO We have to find latest leave based on date . not by created at. #balaraju
    #@latest_leave = @employee.leave_histories.where(:status => "APPROVED").order(created_at: :desc).first
    @latest_leave = @employee.leave_histories.where(status: "APPROVED")
    if EmployeeAttendence.last.present?
    last_week = EmployeeAttendence.last.log_date 
    
    emp_rec = Employee.find_by_user_id(current_user.id)
        
    holiday_list =  Event.where(:id=>emp_rec.group.holiday_calenders.map(&:event_id)).map(&:event_date) if emp_rec.group.present?
    holiday_list = holiday_list.collect{ |holiday| holiday.to_date }
    
    @myattendence = EmployeeAttendence.where("log_date >=? and log_date <= ? and employee_id = ? ", last_week.beginning_of_week, last_week, emp_rec.id).map(&:total_working_hours)
    working_days = 0
    attended_days = 0
    attended_on_weekends = 0
    holiday_count = 0
    (last_week.beginning_of_week.to_datetime..last_week.to_datetime).each do|dat|
    #raise (last_week.beginning_of_week.to_datetime..last_week.to_datetime).to_a.inspect
      working_days += 1
      holiday_count += 1 if holiday_list.include?(dat.to_date)
      if !EmployeeAttendence.where(log_date: dat.strftime("%Y-%m-%d"), employee_id: emp_rec.id).empty?
        attended_days += 1
        attended_on_weekends += 1 if ["Sat","Sun"].include?dat.strftime("%a").to_s
      end
    end

     case attended_on_weekends
      when 0
        working_days = (5 - holiday_count)
      when 1
        working_days = 6
      when 2
        working_days = 7
     end
     
    @attended_days = attended_days
    @working_days = working_days
    #raise @working_days.inspect
    t = @myattendence.sum
    mm, ss = t.divmod(60)
    hh, mm = mm.divmod(60)
  
    @sumofworkinghours = "#{hh}hr #{mm}min"
      
    @avg =  "#{calculate_time_diff(@myattendence.sum/@working_days)}"
    
    end
   else
    redirect_to employees_path
   end
  end  
  
  def wall
    
    @status = Status.new
    @welcome_event = AmzurEvent.get_amzur_events
    @welcome_announcements = Announcement.all.page(params[:page2]).per(2)
    @welcome_recruitments = Recruitment.where(:status => "open").page(params[:page3]).per(2)
    @employee = current_user.employee
    @albums = Album.all
    @statuses = Status.all
    @posts = [@albums, @statuses]
    @posts.flatten!
    @posts.sort!{|a,b|a.updated_at <=> b.updated_at}.reverse!
 end
 

    
  private 
  def calculate_time_diff(time_in_min)  
    t = time_in_min
    mm, ss = t.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    return 0 if (hh+mm+ss).to_i == 0
    return "#{hh.to_i}hr #{mm.to_i}min" if (hh+mm+ss).to_i != 0 #[dd,hh, mm, ss]
  end
end
