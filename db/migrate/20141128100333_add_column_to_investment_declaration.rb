class AddColumnToInvestmentDeclaration < ActiveRecord::Migration
  def change
     add_column :investment_declarations, :assesment_year, :integer
  end
end
