require 'csv'
class EmployeeAttendenceController < ApplicationController

  def index
   
    @allEmployeesIds = TemporaryAttendenceLog.all.map(&:employee_id).uniq
    @attendanceDates = TemporaryAttendenceLog.all.map(&:date_time)
    @attendaceDates = attendanceDates.collect {|dt| dt.to_datetime.strftime("%d-%m-%Y") }
    @attendaceDates = attendaceDates.uniq

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
                EmployeeAttendenceLog.create(employee_attendence_id: emp.id, time:inOutTime , in_out: true)
              else
                timeDiff = TimeDifference.between(inTime, inOutTime).in_each_component
                totalWorkingHours += timeDiff[:hours]
                inFlag = true
                EmployeeAttendenceLog.create(employee_attendence_id: emp.id, time:inOutTime , in_out: false)
              end
          end
          is_emp_present = true if totalWorkingHours!=0
          emp.is_present, emp.total_working_hours =  false, totalWorkingHours
          emp.save
        inOutTimingsArray = TemporaryAttendenceLog.where("demployee_id = ? and ate_time >= ? and date_time < ?", employeeId, logDate.to_datetime.at_noon, logDate.to_datetime.tomorrow.at_noon).map(&:date_time)
        puts totalWorkingHours
      break  
      end
    end
  end 
  
  def show  
    @employeeattendece = EmployeeAttendence.all
  end
  
  def show_attendance
    @employeeattendece = EmployeeAttendence.all
  end


  def upload_file    
    i=0
    @temproray_attachment_log=TemporaryAttendenceLog.destroy_all
    CSV.foreach(filePath) do |column|
    #puts "#{column[2]} - #{column[3]} - #{column[4]}" unless i==0
    @temproray_attachment_log=TemporaryAttendenceLog.create(device_id: column[2], employee_id: column[3], date_time: column[4]) unless i==0
    i+=1
    end    
  end
  
end
