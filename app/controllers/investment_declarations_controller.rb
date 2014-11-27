class InvestmentDeclarationsController < ApplicationController
  
  def index 
    @general_investments = GeneralInvestment.all
    g_ids = @general_investments.map(&:id)
    i_ids =  current_user.employee.investment_declarations.map(&:general_investment_id)
    remaining_ids = g_ids-i_ids
    remaining_ids.each do |id|
     current_user.employee.investment_declarations.create(general_investment_id: id, yearly_value: 0)
    end

    @declarations = current_user.employee.investment_declarations
    @sections = @declarations.map(&:general_investment).map(&:section_declaration).uniq
  
  #adding data to payroll master table @pattabhi 
    sum_of_declarations = InvestmentDeclaration.sum_of_declation(current_user.employee) 
    pay_roll_master = current_user.employee.pay_roll_masters
    if pay_roll_master.present? 
      @payroll = pay_roll_master.first.update(total_savings: sum_of_declarations)   
    else 
      @payroll = PayRollMaster.create(employee_id: current_user.employee.id, assesment_year: Date.today.year, total_savings: sum_of_declarations )
    end
    
  end
  
  def edit
    @declaration = InvestmentDeclaration.find(params[:id])
  end
  
  def update
    @declaration = InvestmentDeclaration.find(params[:id])
    @declaration.update(:general_investment_id =>  @declaration.general_investment_id, :yearly_value => params[:investment_declaration][:yearly_value], :employee_id => current_user.employee.id)
     
     #payroll master update of current user @pattabhi
     sum_of_declarations = InvestmentDeclaration.sum_of_declation(current_user.employee) 
     @declarations = current_user.employee.investment_declarations
     @payroll = current_user.employee.pay_roll_masters.first
     @payroll.update(total_savings: sum_of_declarations )
     redirect_to investment_declarations_path
  end
  
end
