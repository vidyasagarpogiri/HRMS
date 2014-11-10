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
        attendance_hash[rec.employee_id.to_s][rec.log_date.strftime("%a").to_s] = rec.total_working_hours 
      else
        attendance_hash[rec.employee_id.to_s] =  {"Mon" => 0, "Tue" => 0, "Wed" => 0, "Thu" => 0, "Fri" => 0, "Sat" => 0, "Sun" => 0} 
        attendance_hash[rec.employee_id.to_s][rec.log_date.strftime("%a").to_s] = rec.total_working_hours 
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
    in_out_timings = in_out_timings.collect { |dt| dt[0] = dt[0].strftime("%H:%M"); dt  }
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
    #@allUserIds.each do|deviceUserId|
    @employee_devise_ids.each do|deviceUserId|
      @attendaceDates.each do|logDate|
      
        inFlag = true
        inTime = 0
        totalWorkingHours = 0
        is_emp_present = false
        
        emp_rec = Employee.find_by_devise_id(deviceUserId)
        from_work_time = emp_rec.shift.from_time
        to_work_time = emp_rec.shift.to_time
        
        inOutTimingsArray =  if(from_work_time > to_work_time)
        TemporaryAttendenceLog.where("employee_id = ? and date_time >= ? and date_time < ?", deviceUserId, logDate.to_datetime.at_noon, logDate.to_datetime.tomorrow.at_noon).map(&:date_time)
        else
        TemporaryAttendenceLog.where("employee_id = ? and date_time >= ? and date_time < ?", deviceUserId, logDate.to_datetime.beginning_of_day, logDate.to_datetime.end_of_day).map(&:date_time)
        end
        @emp = EmployeeAttendence.create(employee_id: emp_rec.id, log_date: logDate, is_present: is_emp_present, total_working_hours: totalWorkingHours)
          
          inOutTimingsArray.each do |inOutTime|
              if inFlag
                inTime = inOutTime
                inFlag = false
                #EmployeeAttendenceLog.find_or_create_by(employee_id: emp_rec.id, employee_attendence_id: @emp.id, time:inOutTime , in_out: true)
                emp_logs = EmployeeAttendenceLog.find_or_create_by(employee_id: emp_rec.id, time:inOutTime , in_out: true)
                emp_logs.employee_attendence_id = @emp.id
                emp_logs.save
              else
                timeDiff = TimeDifference.between(inTime, inOutTime).in_each_component
                totalWorkingHours += timeDiff[:hours]
                inFlag = true
                #EmployeeAttendenceLog.find_or_create_by(employee_id: emp_rec.id, employee_attendence_id: @emp.id, time:inOutTime , in_out: false)
                EmployeeAttendenceLog.find_or_create_by(employee_id: emp_rec.id, time:inOutTime , in_out: false)
                emp_logs.employee_attendence_id = @emp.id
                emp_logs.save
              end
          end
          is_emp_present = true if totalWorkingHours!=0
          totalWorkingHours_str = totalWorkingHours.to_s.split(".")
          totalWorkingHours_hrs = totalWorkingHours_str[0]
          totalWorkingHours_min = "0.#{totalWorkingHours_str[1]}".to_f.minutes.to_i
          @emp.is_present, @emp.total_working_hours = is_emp_present, "#{totalWorkingHours_hrs}.#{totalWorkingHours_min}".to_f
          @emp.save
        #puts totalWorkingHours
      end
    end
    redirect_to "/employee_attendence/show_attendance"
  end
  
  def emp_show_attendance
  
  end
  
  def emp_show_attendance_ws    
    last_week = EmployeeAttendence.where(:employee_id=>current_user.employee.id).last.log_date
    
    last_week = EmployeeAttendence.where(:employee_id=>current_user.employee.id).last.log_date.to_datetime + params["week_no"].to_i.week if params["week_no"].present?
    
   # @employeeattendece = EmployeeAttendenceLog.where("time >? and time < ? and employee_id = ? ", last_week.beginning_of_week, last_week.end_of_week,  current_user.employee.id)
         
    complete_week = last_week.beginning_of_week
    attendance_hash = {"Mon" => {:total_hrs=>0, :logs=>[], :dt=>complete_week.strftime("%d-%m-%Y")}, "Tue" => {:total_hrs=>0, :logs=>[], :dt=>( complete_week + 1.day).strftime("%d-%m-%Y")}, "Wed" => {:total_hrs=>0, :logs=>[], :dt=>(complete_week + 2.day).strftime("%d-%m-%Y")}, "Thu" => {:total_hrs=>0, :logs=>[], :dt=>(complete_week + 3.day).strftime("%d-%m-%Y")}, "Fri" => {:total_hrs=>0, :logs=>[], :dt=>(complete_week+ 4.day).strftime("%d-%m-%Y")}, "Sat" => {:total_hrs=>0, :logs=>[], :dt=>(complete_week + 5.day).strftime("%d-%m-%Y")}, "Sun" => {:total_hrs=>0, :logs=>[], :dt=>(complete_week + 6.day).strftime("%d-%m-%Y")}}      
 
=begin   
    @employeeattendece.each do|logs|
      lg ="out"
      lg ="in" if logs.in_out
      attendance_hash[logs.time.strftime("%a").to_s][:logs] << "#{logs.time.strftime("%H:%M")} #{lg}"
      attendance_hash[logs.time.strftime("%a").to_s][:total_hrs] = EmployeeAttendence.where(:employee_id=>current_user.id, :log_date=>logs.time.strftime("%Y-%m-%d")).first.total_working_hours
    end
=end

#---------------         
    emp_rec = Employee.find_by_user_id(current_user.id)
    from_work_time = emp_rec.shift.from_time
    to_work_time = emp_rec.shift.to_time
    week_working_hours = 0.0

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
        attendance_hash[w_day.strftime("%a").to_s][:logs] << "#{logs.time.strftime("%H:%M")} #{lg}"
        attendance_hash[w_day.strftime("%a").to_s][:total_hrs] = EmployeeAttendence.where(:employee_id=>emp_rec.id, :log_date=>w_day.strftime("%Y-%m-%d")).first.total_working_hours
      end
      
      week_working_hours_str = attendance_hash[w_day.strftime("%a").to_s][:total_hrs].to_s.split(".")
      #week_working_hours_hrs = week_working_hours_str[0]
      week_working_hours_hrs = week_working_hours_str[0].to_f
      #week_working_hours_min = "0.#{week_working_hours_str[1]}".to_f.minutes.to_i.to_s
      week_working_hours_min = "0.#{week_working_hours_str[1]}".to_f
      week_working_hours_hrs += week_working_hours_min % 60
      week_working_hours_min = week_working_hours_min / 60
      
      week_working_hours_min = week_working_hours_min.to_s.length==1? "0#{week_working_hours_min}" : "#{week_working_hours_min}" 
      
      attendance_hash[w_day.strftime("%a").to_s][:total_hrs] = "#{week_working_hours_hrs}.#{week_working_hours_min}".to_f
    
      
    end
    
      attendance_hash.each do|wrk_day, wrk_hrs|
        week_working_hours +=wrk_hrs[:total_hrs]
      end
          working_days = TimeDifference.between(last_week, last_week.beginning_of_week).in_general[:days]
      
          week_working_hours_str = week_working_hours.to_s.split(".")
          week_working_hours_hrs = week_working_hours_str[0]
          week_working_hours_min = "0.#{week_working_hours_str[1]}".to_f.minutes.to_i.to_s
          
          week_working_hours_min = week_working_hours_min.length==1? "0#{week_working_hours_min}" : "#{week_working_hours_min}" 
      
          attendance_hash_json = {}
          attendance_hash_json[:week_data] = attendance_hash
          
          sumofworkinghours = EmployeeAttendence.where("log_date >=? and log_date <= ?  and employee_id = ? ", last_week.beginning_of_week, last_week, emp_rec.id).map(&:total_working_hours).sum
          
          week_working_hours_str = sumofworkinghours.to_s.split(".")
          #week_working_hours_hrs = week_working_hours_str[0]
          week_working_hours_str = week_working_hours_str.split(".")[0]
          week_working_hours_hrs = week_working_hours_str[0].to_f
          #week_working_hours_min = "0.#{week_working_hours_str[1]}".to_f.minutes.to_i.to_s
          week_working_hours_min = "#{week_working_hours_str[1]}".to_f

          week_working_hours_hrs += (week_working_hours_min/60).to_i
          week_working_hours_min = (week_working_hours_min.to_f%60).to_i
          
          week_working_hours_min = week_working_hours_min.to_s.length==1? "0#{week_working_hours_min}" : "#{week_working_hours_min}" 
          
          sumofworkinghours ="#{week_working_hours_hrs.to_i.to_s[0]}#{week_working_hours_hrs.to_i.to_s[1]}.#{week_working_hours_min}".to_f
                    #raise sumofworkinghours.inspect
          #attendance_hash_json[:total_week_hours] = "#{week_working_hours_hrs}.#{week_working_hours_min}".to_f
          attendance_hash_json[:total_week_hours] = sumofworkinghours.round(2)
          
          
          #all_employees = Employee.where(shift_id: emp_rec.shift_id).map(&:devise_id)
    
          #all_wk_days = TemporaryAttendenceLog.where(employee_id: all_employees).map(&:date_time)
          all_wk_days = TemporaryAttendenceLog.where(employee_id: emp_rec.devise_id).map(&:date_time)

          all_wk_days = all_wk_days.collect {|x| x.to_date.to_datetime }
          all_wk_days = all_wk_days.uniq
          
          i=0
          (last_week.beginning_of_week.to_datetime..last_week.to_datetime).each do|dat|
            i+=1 if all_wk_days.include?(dat)
          end
          
          working_days = i
          
          avg_week_working_hours_str = ( sumofworkinghours / working_days.to_f).round(2)
          
          avg_week_working_hours_str = avg_week_working_hours_str.to_s.split(".")
          avg_week_working_hours_hrs = avg_week_working_hours_str[0].to_f
          avg_week_working_hours_min = "#{avg_week_working_hours_str[1]}".to_f

          avg_week_working_hours_hrs += (avg_week_working_hours_min/60).to_i
          avg_week_working_hours_min = (avg_week_working_hours_min.to_f%60)

          avg_week_working_hours_min = avg_week_working_hours_min.to_s.length==1? "0#{avg_week_working_hours_min}" : "#{avg_week_working_hours_min}"
          
          attendance_hash_json[:avg_week_hours] =  "#{avg_week_working_hours_hrs.to_i}.#{avg_week_working_hours_min.to_i}".to_f
          
          
#--------------------    
    
    respond_to do |format|
      format.json { render json: attendance_hash_json }
    end
  
  end  
end
