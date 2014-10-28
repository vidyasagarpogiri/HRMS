class CreateInvestmentDeclarations < ActiveRecord::Migration
  def change
    create_table :investment_declarations do |t|
      t.string :section
      t.string :title
      t.float :max_limit
      t.text :description
      t.float :monthly_value
      t.float :yearly_value
      t.integer :employee_id

      t.timestamps
    end
  end
end
