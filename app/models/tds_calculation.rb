class TdsCalculation 

  def initialize(gross, employee_id, old_tds = nil, new_tds = nil)
    @gross = gross
    @employee = Employee.find(employee_id)
    @old_tds = old_tds.to_f 
    @new_tds = new_tds if new_tds
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
    if t.present?
      @income_tax = t.min_tax + ((tax_income - t.lower_limit)*(t.tax_percentage/100))
      @education_cess = (@income_tax * 2)/100
      @higher_education_cess = (@income_tax)/100
      @total_tax = @income_tax + @education_cess + @higher_education_cess
      @total_tax.to_f
    else
      0.0
    end
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
      if @pay_roll_master.present?
        @pay_roll_master.update(net_taxable_income: @net_taxable_income, income_tax: @income_tax, education_cess: @education_cess, higher_education_cess: @higher_education_cess, total_tax: @total_tax, status: "open", total_tds: @pay_roll_master.total_tds + @tds - @old_tds ) 
      else
        @employee.pay_roll_masters.create(net_taxable_income: @net_taxable_income, income_tax: @income_tax, education_cess: @education_cess, higher_education_cess: @higher_education_cess, total_tax: @total_tax, status: "open", total_tds:  @tds, assesment_year: Date.today, total_income: @employee.salary.ctc_fixed )
      end
     @tds
    end
  end
  
  
  def only_tds_modification
    if @employee.present? 
      @pay_roll_master = @employee.pay_roll_masters.first        
      @pay_roll_master.update(status: "open", total_tds: @pay_roll_master.total_tds + @new_tds.to_f - @old_tds.to_f ) if @pay_roll_master.present?
    end
    @new_tds
  end
  
end

