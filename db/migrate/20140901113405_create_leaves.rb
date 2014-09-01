class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.float :pl_carry_forward_preves_year
      t.float :pl_applied
      t.float :sl_applied
      t.float :lop_applied

      t.timestamps
    end
  end
end
