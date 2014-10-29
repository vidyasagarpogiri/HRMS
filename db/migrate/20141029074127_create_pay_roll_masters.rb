class CreatePayRollMasters < ActiveRecord::Migration
  def change
    create_table :pay_roll_masters do |t|
      t.date :assesment_year
      t.float :total_income
      t.float :total_savings
      t.float :total_tds
      t.timestamps
    end
  end
end
