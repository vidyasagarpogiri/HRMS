require 'csv'
class EmployeeAttendenceController < ApplicationController

  def index
    @employeeattendece = EmployeeAttendence.all    
  end 
  
  def show  
    #@employeeattendece = EmployeeAttendence.all
  end
  
  def attandence_ws
    last_week = EmployeeAttendence.last.log_date 
    last_week = EmployeeAttendence.last.log_date.to_datetime + params["week_no"].to_i.week if params["week_no"].present?    
    @employeeattendece = EmployeeAttendence.where("log_date >? and log_date < ?", last_week.beginning_of_week, last_week.end_of_week)
    week_days = last_week.beginning_of_week
    attendance_hash = {"dt"=>{ "Mon"=>week_days.strftime("%d-%m-%Y"), "Tue"=>(week_days + 1.day).strftime("%d-%m-%Y"), "Wed"=>(week_days + 2.day).strftime("%d-%m-%Y"), "Thu"=>(week_days + 3.day).strftime("%d-%m-%Y"), "Fri"=>(week_days + 4.day).strftime("%d-%m-%Y"), "Sat"=>(week_days + 5.day).strftime("%d-%m-%Y"), "Sun"=>(week_days + 6.day).strftime("%d-%m-%Y")}} 
    @employeeattendece.each do|rec|
      if attendance_hash.has_key?(rec.employee_id.to_s)
        attendance_hash[rec.employee_id.to_s][rec.log_date.strftime("%a").to_s] = calculate_time_diff(rec.total_working_hours)
      else
        attendance_hash[rec.employee_id.to_s] =  {"Mon" => 0, "Tue" => 0, "Wed" => 0, "Thu" => 0, "Fri" => 0, "Sat" => 0, "Sun" => 0} 
        attendance_hash[rec.employee_id.to_s][rec.log_date.strftime("%a").to_s] = calculate_time_diff(rec.total_working_hours)
      end
    end
    respond_to do |format|
      format.json { render json: attendance_hash }
    end
  end
  
  def attendence_log_ws
   usr = current_user.employee
   usr = Employee.find(params[:emp_id]) if params[:emp_id].present?
   current_date = Time.now
   from_work_time = usr.shift.from_time
   to_work_time = usr.shift.to_time
   current_date = params[:dt].to_datetime
   log_date = current_date.strftime("%d-%m-%Y")
   current_date = params["dt"].to_datetime if params["dt"].present?
    
    @employee_attendence_logs = if(from_work_time > to_work_time)
    EmployeeAttendenceLog.where("time >= ? and time <= ? and employee_id = ? ",current_date.to_datetime.at_noon, current_date.to_datetime.tomorrow.at_noon,  usr.id)
    else 
    EmployeeAttendenceLog.where("time >= ? and time <= ? and employee_id = ? ",current_date.beginning_of_day, current_date.end_of_day,  usr.id)
    end
    
    in_out_timings = @employee_attendence_logs.pluck("time, in_out")
    in_out_timings = in_out_timings.collect { |dt| dt[0] = dt[0].strftime("%H:%M:%S"); dt  }
    in_out_timings_json = {}
    in_out_timings_json = {:logs=> in_out_timings, :dt=>[log_date]}
    respond_to do |format|
      format.json { render json:  in_out_timings_json }
    end
  end
  
  def show_attendance
   if current_user.department == Department::HR
    @employees =  Employee.where(:status => false)
   elsif current_user.degnation 
   end  
  end

  def new_attendence_log
    @employee_attendence_log_file = EmployeeAttendenceLogFile.new
  end
  
  def upload_file    
   uploader = AttendenceLogCsvUploader.new
   uploader.store!(params[:employee_attendence_log_file][:log_file])

   #raise uploader.path.inspect
    #TemporaryAttendenceLog.destroy_all
    ActiveRecord::Base.connection.execute("TRUNCATE temporary_attendence_logs") #destroying temporaryattendancelogs
    bulk_insert = []
    i=0
    CSV.foreach(uploader.path) do |column|
      bulk_insert.push"(#{column[2].to_i}, #{column[3].to_i}, '#{column[4]}')" unless i==0
      i+=1
    end
    ActiveRecord::Base.connection.execute("INSERT INTO temporary_attendence_logs(`device_id`, `employee_id`, `date_time`) VALUES #{bulk_insert.join(', ')}")  
    #creating temporaryattendancelogs
        
    @allUserIds = TemporaryAttendenceLog.all.map(&:employee_id).uniq
    @attendanceDates = TemporaryAttendenceLog.all.map(&:date_time).compact
    @attendaceDates = @attendanceDates.collect {|dt| dt.to_datetime.strftime("%d-%m-%Y") }
    @attendaceDates = @attendaceDates.uniq

    @employee_devise_ids = Employee.where(:status=>false).map(&:devise_id).compact.uniq
    @employee_devise_ids.each do|deviceUserId|
      @attendaceDates.each do|logDate|
      
        inFlag = true
        inTime = 0
        
        emp_rec = Employee.find_by_devise_id(deviceUserId)
        from_work_time = emp_rec.shift.from_time
        to_work_time = emp_rec.shift.to_time
        
        inOutTimingsArray =  if(from_work_time > to_work_time)
        TemporaryAttendenceLog.where("employee_id = ? and date_time >= ? and date_time < ?", deviceUserId, logDate.to_datetime.at_noon, logDate.to_datetime.tomorrow.at_noon).map(&:date_time)
        else
        TemporaryAttendenceLog.where("employee_id = ? and date_time >= ? and date_time < ?", deviceUserId, logDate.to_datetime.beginning_of_day, logDate.to_datetime.end_of_day).map(&:date_time)
        end
        
          inOutTimingsArray.each do |inOutTime|
              if inFlag
                inTime = inOutTime
                inFlag = false
                EmployeeAttendenceLog.find_or_create_by(devise_id: deviceUserId, employee_id: emp_rec.id, time:inOutTime , in_out: true)
              else
                inFlag = true
                EmployeeAttendenceLog.find_or_create_by(devise_id: deviceUserId, employee_id: emp_rec.id, time:inOutTime , in_out: false)
              end
          end
      end
    end
    
    @employee_devise_ids.each do|deviceUserId|
      @attendaceDates.each do|logDate|
        emp_rec = Employee.find_by_devise_id(deviceUserId)
        from_work_time = emp_rec.shift.from_time
        to_work_time = emp_rec.shift.to_time
        
        employeeAttendenceLogs =  if(from_work_time > to_work_time)
        EmployeeAttendenceLog.where("devise_id=? and employee_id = ? and time >= ? and time < ?", deviceUserId, emp_rec.id, logDate.to_datetime.at_noon, logDate.to_datetime.tomorrow.at_noon)
        else
        EmployeeAttendenceLog.where("devise_id=? and employee_id = ? and time >= ? and time < ?", deviceUserId, emp_rec.id, logDate.to_datetime.beginning_of_day, logDate.to_datetime.end_of_day)
        end

#        raise worked_hours.inspect

        totalWorkingHours = 0.0
        is_emp_present = false
        
        worked_hours = employeeAttendenceLogs.map(&:time)
        worked_hours.each_with_index do|w_hr, index|
          break if worked_hours.count == index+1
          if index.even?
            totalWorkingHours += worked_hours[index+1] - worked_hours[index]
          end
        end
#        raise totalWorkingHours.inspect
        
        is_emp_present = true if totalWorkingHours.to_f != 0.0 
        
        @empAttendence = if EmployeeAttendence.where(employee_id: emp_rec.id, log_date: logDate.to_date).empty?
         EmployeeAttendence.create(employee_id: emp_rec.id, log_date: logDate)
        else
         EmployeeAttendence.where(employee_id: emp_rec.id, log_date: logDate.to_date).first
        end
        
        @empAttendence.is_present = is_emp_present
        @empAttendence.total_working_hours = totalWorkingHours
        @empAttendence.save 
        
        employeeAttendenceLogs.update_all(employee_attendence_id: @empAttendence.id)
        
      end
    end  
      
    redirect_to "/employee_attendence/show_attendance"
  end
  
  def emp_show_attendance
  
  end
  
  def emp_show_attendance_ws    
    last_week = EmployeeAttendence.where(:employee_id=>current_user.employee.id).last.log_date
    
    last_week = EmployeeAttendence.where(:employee_id=>current_user.employee.id).last.log_date.to_datetime + params["week_no"].to_i.week if params["week_no"].present?
         
    complete_week = last_week.beginning_of_week
    attendance_hash = {"Mon" => {:total_hrs=>0, :logs=>[], :dt=>complete_week.strftime("%d-%m-%Y")}, "Tue" => {:total_hrs=>0, :logs=>[], :dt=>( complete_week + 1.day).strftime("%d-%m-%Y")}, "Wed" => {:total_hrs=>0, :logs=>[], :dt=>(complete_week + 2.day).strftime("%d-%m-%Y")}, "Thu" => {:total_hrs=>0, :logs=>[], :dt=>(complete_week + 3.day).strftime("%d-%m-%Y")}, "Fri" => {:total_hrs=>0, :logs=>[], :dt=>(complete_week+ 4.day).strftime("%d-%m-%Y")}, "Sat" => {:total_hrs=>0, :logs=>[], :dt=>(complete_week + 5.day).strftime("%d-%m-%Y")}, "Sun" => {:total_hrs=>0, :logs=>[], :dt=>(complete_week + 6.day).strftime("%d-%m-%Y")}}      

    emp_rec = Employee.find_by_user_id(current_user.id)
    from_work_time = emp_rec.shift.from_time
    to_work_time = emp_rec.shift.to_time
    week_working_hours = []
      
    (0..6).each do|days|
      w_day = complete_week + days.day
      
      @emp_employeeattendece =  if(from_work_time > to_work_time)
        EmployeeAttendenceLog.where("time >? and time < ? and employee_id = ? ", w_day.at_noon, w_day.tomorrow.at_noon,  current_user.employee.id)
       else
        EmployeeAttendenceLog.where("time >? and time < ? and employee_id = ? ", w_day.beginning_of_day, w_day.end_of_day,  current_user.employee.id)
      end   
      
      @emp_employeeattendece.each do|logs|
        lg ="out"
        lg ="in" if logs.in_out
        attendance_hash[w_day.strftime("%a").to_s][:logs] << "#{logs.time.strftime("%H:%M:%S")} #{lg}"
      end
      
        emp_att = EmployeeAttendence.where(:employee_id=>emp_rec.id, :log_date=>w_day.strftime("%Y-%m-%d"))
        if emp_att.first.present?
          attendance_hash[w_day.strftime("%a").to_s][:total_hrs] = calculate_time_diff(EmployeeAttendence.where(:employee_id=>emp_rec.id, :log_date=>w_day.strftime("%Y-%m-%d")).first.total_working_hours)
          week_working_hours << EmployeeAttendence.where(:employee_id=>emp_rec.id, :log_date=>w_day.strftime("%Y-%m-%d")).first.total_working_hours
        end
      end      
      
      working_days = 0
      attended_days = 0
      attended_on_weekends = 0
      (last_week.beginning_of_week.to_datetime..last_week.to_datetime).each do|dat|
      raise (last_week.beginning_of_week.to_datetime..last_week.to_datetime).to_a.inspect
        working_days += 1
        if !EmployeeAttendence.where(log_date: dat.strftime("%Y-%m-%d"), employee_id: emp_rec.id).empty?
          attended_days += 1
          attended_on_weekends += 1 if ["Sat","Sun"].include?dat.strftime("%a").to_s
        end
      end

       case attended_on_weekends
        when 0
          working_days = 5
        when 1
          working_days = 6
        when 2
          working_days = 7
       end
      
      attendance_hash_json = {}
      attendance_hash_json[:week_data] = attendance_hash
        
      sumofworkinghours = calculate_time_diff(week_working_hours.sum)
      attendance_hash_json[:total_week_hours] = calculate_time_diff(week_working_hours.sum)
      attendance_hash_json[:avg_week_hours] =   calculate_time_diff(week_working_hours.sum / working_days)

      respond_to do |format|
       format.json { render json: attendance_hash_json }
      end
  end  
  
  private 
  def calculate_time_diff(time_in_min)  
    t = time_in_min
    mm, ss = t.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    return 0 if (hh+mm+ss).to_i == 0
    return "#{hh.to_i}hr #{mm.to_i}min #{ss.to_i}sec" if (hh+mm+ss).to_i != 0 #[dd,hh, mm, ss]
  end
end
