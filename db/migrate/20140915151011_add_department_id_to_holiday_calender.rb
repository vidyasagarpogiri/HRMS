class AddDepartmentIdToHolidayCalender < ActiveRecord::Migration
  def change
    add_column :holiday_calenders, :department_id, :integer
  end
end
