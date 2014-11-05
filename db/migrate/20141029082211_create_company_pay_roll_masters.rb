class CreateCompanyPayRollMasters < ActiveRecord::Migration
  def change
    create_table :company_pay_roll_masters do |t|
      t.string :month
      t.integer :year
      t.string :status
      t.string :name

      t.timestamps
    end
  end
end
