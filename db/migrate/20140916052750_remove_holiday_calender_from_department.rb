class RemoveHolidayCalenderFromDepartment < ActiveRecord::Migration
  def change
  remove_column :departments, :holiday_calender_id
  end
end
