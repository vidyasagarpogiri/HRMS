class CreateInvestmentDeclarations < ActiveRecord::Migration
  def change
    create_table :investment_declarations do |t|
      t.integer :generic_investment_declaration_id
      t.float :monthly_value
      t.float :yearly_value
      t.integer :employee_id

      t.timestamps
    end
  end
end
