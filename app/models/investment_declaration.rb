class InvestmentDeclaration < ActiveRecord::Base
  belongs_to :employee
  belongs_to :generic_investment_declaration
end
