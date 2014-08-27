class CreateAllowances < ActiveRecord::Migration
  def change
    create_table :allowances do |t|
      t.string :allowance_name
      t.float :value

      t.timestamps
    end
  end
end
