class CreateStaticSalaries < ActiveRecord::Migration
  def change
    create_table :static_salaries do |t|
      t.string :name
      t.float :value
      t.timestamps
    end
  end
end
