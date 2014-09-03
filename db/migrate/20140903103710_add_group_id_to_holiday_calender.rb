class AddGroupIdToHolidayCalender < ActiveRecord::Migration
  def change
    add_column :holiday_calenders, :group_id, :integer
  end
end
