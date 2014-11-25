class TdsCalculation 

  def initialize(gross, employee_id)
    @gross = gross
    @employee = Employee.find(employee_id)
  end
  
  def net_taxble_income
    @net_taxable_income = (@gross*12)-total_savings
  end
  
  def total_savings
    @employee.investment_declarations.sum(:yearly_value)
  end
  
  def tax
    tax_income = net_taxble_income
    t = TaxBracket.where("lower_limit < ? && upper_limit > ?", tax_income, tax_income).first
    @income_tax = t.min_tax + ((tax_income - t.lower_limit)*(t.tax_percentage/100))
    @education_cess = (@income_tax * 2)/100
    @higher_education_cess = (@income_tax)/100
    @total_tax = @income_tax + @education_cess + @higher_education_cess
    @total_tax.to_f
  end
  
  def tds_for_this_month
    @month = DateTime.now.month - 1
    @remaining_months = if @month <  4
       4 - @month
    else
      16 - @month 
    end
   @tds = (tax)/12
   
   if @employee.present? 
    @pay_roll_master = @employee.pay_roll_masters.first
    @pay_roll_master.update(net_taxable_income: @net_taxable_income, income_tax: @income_tax, education_cess: @education_cess, higher_education_cess: @higher_education_cess, total_tax: @total_tax, status: "open", total_tds: @pay_roll_master.total_tds + @tds  ) if @pay_roll_master.present?
    
    @tds
  end
  end
  
end

