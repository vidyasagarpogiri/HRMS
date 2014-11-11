class CreateLeaveHistories < ActiveRecord::Migration
  def change
    create_table :leave_histories do |t|
      t.string :from_date
      t.string :to_date
      #t.integer :days
      t.text :reason
      t.text :feedback
      t.integer :leave_type_id
      t.integer :employee_id

      t.timestamps
    end
  end
end
