class InvestmentDeclaration < ActiveRecord::Base
  belongs_to :employee
  belongs_to :general_investment
  
  
  
  # TODO BalaRaju find the sum of total investement values.
  #It is depends on section Maximum value
  #have to reduce the code  
  def self.sum_of_declation(employee)
    @employee = employee
    sum = 0
    SectionDeclaration.all.each do |section|
      section_value = 0
      yearly_value = 0
      section.general_investments.each do |general_investment|
        investment = @employee.investment_declarations.where(:general_investment_id => general_investment.id)
        if investment.present?
          yearly_value += investment.first.yearly_value
        end
      end
      section_value = section.maximum_limit < yearly_value ? section.maximum_limit : yearly_value
      sum += section_value
    end
    sum
  end
  

  
end


