class AddColumnGroupIdToHolidayCalander < ActiveRecord::Migration
  def change
    add_column :holiday_calanders, :group_id, :integer
  end
end
