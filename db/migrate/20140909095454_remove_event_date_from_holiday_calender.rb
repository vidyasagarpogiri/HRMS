class RemoveEventDateFromHolidayCalender < ActiveRecord::Migration
  def change
  remove_column :holiday_calenders, :event
  remove_column :holiday_calenders, :date
  end
end
