class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.string :name
      t.string :from_time
      t.string :to_time
      t.boolean :is_next_day

      t.timestamps
    end
  end
end
