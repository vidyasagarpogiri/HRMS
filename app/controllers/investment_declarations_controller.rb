class InvestmentDeclarationsController < ApplicationController
  
  def index
   # raise params.inspect
 
    @general_investments = GeneralInvestment.all
    g_ids = @general_investments.map(&:id)
    i_ids = InvestmentDeclaration.all.map(&:general_investment_id)
    remaining_ids = g_ids-i_ids
    remaining_ids.each do |id|
      InvestmentDeclaration.create(general_investment_id: id, yearly_value: 0, employee_id: current_user.employee.id )
    end

    @declarations = current_user.employee.investment_declarations
  #adding data to payroll master table @pattabhi  
    unless current_user.employee.pay_roll_masters.present? 
       @payroll = PayRollMaster.create(:employee_id => current_user.employee.id, :assesment_year => Date.today, :total_income => current_user.employee.salary.ctc_fixed, :total_savings => @declarations.sum(:yearly_value) )
    end
    
  end
  
  def edit
    @declaration = InvestmentDeclaration.find(params[:id])
  end
  
  def update
    @declaration = InvestmentDeclaration.find(params[:id])
   
     @declaration.update(:general_investment_id =>  @declaration.general_investment_id, :yearly_value => params[:investment_declaration][:yearly_value], :employee_id => current_user.employee.id)
     
     #payroll master update of current user @pattabhi
     @declarations = current_user.employee.investment_declarations
     
     @payroll = current_user.employee.pay_roll_masters.first
     @payroll.update(:total_savings => @declarations.sum(:yearly_value) )
     
     
     redirect_to investment_declarations_path
  end
  
end
 

