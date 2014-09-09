class AddEventToHolidayCalender < ActiveRecord::Migration
  def change
    add_column :holiday_calenders, :event_id, :integer
  end
end
