class CreateStaticAllowances < ActiveRecord::Migration
  def change
    create_table :static_allowances do |t|
      t.string :allowance_name
      t.float :percentage
			t.boolean :applicable
      t.timestamps
    end
  end
end
