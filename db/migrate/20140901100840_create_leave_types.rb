class CreateLeaveTypes < ActiveRecord::Migration
  def change
    create_table :leave_types do |t|
      t.string :type_name
      t.integer :group_id

      t.timestamps
    end
  end
end
