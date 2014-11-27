class TdsCalculation 

  def initialize(gross, employee_id, tds = nil)
    @gross = gross
    @employee = Employee.find(employee_id)
    @tds = tds.to_f 
    @pay_roll_master = @employee.pay_roll_masters
  end
  
  def net_taxble_income
    (@gross*12)-total_savings
  end
  
  def total_savings
    @employee.investment_declarations.sum(:yearly_value)
  end
  
  def tax
    tax_income = net_taxble_income
    t = TaxBracket.where("lower_limit < ? && upper_limit > ?", tax_income, tax_income).first
    if t.present?
      income_tax = t.min_tax + ((tax_income - t.lower_limit)*(t.tax_percentage/100))
      education_cess = (income_tax * 2)/100
      higher_education_cess = (income_tax)/100
      @total_tax = income_tax + education_cess + higher_education_cess
      @total_tax.to_f
    else
      0.0
    end
  end
  
  def tds_for_this_month
    month = DateTime.now.month - 1
    remaining_months = if month <  4
      4 - month
    else
      16 - month 
    end
    old_tds =  @pay_roll_master.present? ? @pay_roll_master.first.total_tds : 0.0
    @tds = (tax - old_tds)/remaining_months
  end

  
  def tds_and_income_tax_update
    if @employee.present? 
      if @pay_roll_master.present?
        @pay_roll_master.first.update( status: "open", total_tds: @pay_roll_master.first.total_tds + @tds, total_income: @pay_roll_master.first.total_income + @gross ) 
      else
        @employee.pay_roll_masters.create( status: "open", total_tds:  @tds, assesment_year: Date.today.year, total_income: @gross )
      end
    end
  end

end


