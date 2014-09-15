class AddHolidayCalenderIdToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :holiday_calender_id, :integer
  end
end
