class GeneralInvestment < ActiveRecord::Base
   belongs_to :section_declaration
   has_many :investment_declarations
end
