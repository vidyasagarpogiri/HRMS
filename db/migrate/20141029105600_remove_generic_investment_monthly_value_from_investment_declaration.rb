class RemoveGenericInvestmentMonthlyValueFromInvestmentDeclaration < ActiveRecord::Migration
  def change
    rename_column :investment_declarations, :generic_investment_declaration_id, :general_investment_id
    remove_column :investment_declarations, :monthly_value
  end
end
