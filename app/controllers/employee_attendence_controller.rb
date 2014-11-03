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
    attendance_hash = {} 
    @employeeattendece.each do|rec|
      if attendance_hash.has_key?(rec.employee_id.to_s)
        attendance_hash[rec.employee_id.to_s][rec.log_date.strftime("%a").to_s] = rec.total_working_hours 
      else
        attendance_hash[rec.employee_id.to_s] =  {"Mon" => 0, "Tue" => 0, "Wed" => 0, "Thu" => 0, "Fri" => 0} 
        attendance_hash[rec.employee_id.to_s][rec.log_date.strftime("%a|%d-%m-%Y").to_s] = rec.total_working_hours 
      end
    end
    respond_to do |format|
      format.json { render json: attendance_hash }
    end
  end
  
  def attendence_log_ws
   current_date = Time.now
   current_date = params["dt"].to_datetime if params["dt"].present?
    @employee_attendence_logs = EmployeeAttendenceLog.where("time >= ? and time <= ?", current_date.beginning_of_day, current_date.end_of_day)
    in_out_timings = @employee_attendence_logs.pluck("time, in_out")
    respond_to do |format|
      format.json { render json:  in_out_timings }
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
   i=0
    @temproray_attachment_log=TemporaryAttendenceLog.destroy_all
    CSV.foreach(uploader.path) do |column|
    #puts "#{column[2]} - #{column[3]} - #{column[4]}" unless i==0
    @temproray_attachment_log=TemporaryAttendenceLog.create(device_id: column[2], employee_id: column[3], date_time: column[4]) unless i==0
    i+=1
    end      
    @allEmployeesIds = TemporaryAttendenceLog.all.map(&:employee_id).uniq
    @attendanceDates = TemporaryAttendenceLog.all.map(&:date_time)
    @attendaceDates = @attendanceDates.collect {|dt| dt.to_datetime.strftime("%d-%m-%Y") }
    @attendaceDates = @attendaceDates.uniq

    @allEmployeesIds.each do|employeeId|
      @attendaceDates.each do|logDate|
        inFlag = true
        inTime = 0
        totalWorkingHours = 0
        is_emp_present = false
        inOutTimingsArray = TemporaryAttendenceLog.where("employee_id = ? and date_time >= ? and date_time < ?", employeeId, logDate.to_datetime.beginning_of_day, logDate.to_datetime.end_of_day).map(&:date_time)
          @emp = EmployeeAttendence.create(employee_id: employeeId, log_date: logDate, is_present: is_emp_present, total_working_hours: totalWorkingHours)
          inOutTimingsArray.each do |inOutTime|
              if inFlag
                inTime = inOutTime
                inFlag = false
                EmployeeAttendenceLog.create(employee_attendence_id: @emp.id, time:inOutTime , in_out: true)
              else
                timeDiff = TimeDifference.between(inTime, inOutTime).in_each_component
                totalWorkingHours += timeDiff[:hours]
                inFlag = true
                EmployeeAttendenceLog.create(employee_attendence_id: @emp.id, time:inOutTime , in_out: false)
              end
          end
          is_emp_present = true if totalWorkingHours!=0
          @emp.is_present, @emp.total_working_hours = is_emp_present, totalWorkingHours
          @emp.save
        #inOutTimingsArray = TemporaryAttendenceLog.where("employee_id = ? and date_time >= ? and date_time < ?", employeeId, logDate.to_datetime.at_noon, logDate.to_datetime.tomorrow.at_noon).map(&:date_time)
        puts totalWorkingHours
      end
    end
    redirect_to ""
  end
  
end
