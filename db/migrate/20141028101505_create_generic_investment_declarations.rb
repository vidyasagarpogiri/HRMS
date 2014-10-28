class CreateGenericInvestmentDeclarations < ActiveRecord::Migration
  def change
    create_table :generic_investment_declarations do |t|
      t.string :section
      t.string :title
      t.float :maximum_limit
      t.text :description

      t.timestamps
    end
  end
end
