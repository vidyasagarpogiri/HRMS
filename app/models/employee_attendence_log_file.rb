class EmployeeAttendenceLogFile < ActiveRecord::Base
  mount_uploader :log_file, AttendenceLogCsvUploader
end
