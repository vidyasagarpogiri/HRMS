class CreateHolidayCalanders < ActiveRecord::Migration
  def change
    create_table :holiday_calanders do |t|
      t.string :date
      t.string :event
      t.boolean :mandatory_or_optional

      t.timestamps
    end
  end
end
