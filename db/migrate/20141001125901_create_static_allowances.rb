class CreateStaticAllowances < ActiveRecord::Migration
  def change
    create_table :static_allowances do |t|
      t.string :name
      t.float :percentage
      t.float :value
      t.timestamps
    end
  end
end
