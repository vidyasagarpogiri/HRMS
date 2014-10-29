class InvestmentDeclarationsController < ApplicationController
  
  def index
   # raise params.inspect
 
    @general_investments = GeneralInvestment.all
    g_ids = @general_investments.map(&:id)
    i_ids = InvestmentDeclaration.all.map(&:general_investment_id)
    remaining_ids = g_ids-i_ids
    remaining_ids.each do |id|
      InvestmentDeclaration.create(general_investment_id: id, monthly_value: 0, yearly_value: 0, employee_id: current_user.employee.id )
    end
    @declarations = InvestmentDeclaration.all
  end
  
  def edit
    @declaration = InvestmentDeclaration.find(params[:id])
  end
  
  def update
    @declaration = InvestmentDeclaration.find(params[:id])
    #raise params[:investment_declaration][:monthly_value].inspect
     @declaration.update(:general_investment_id =>  @declaration.general_investment_id, :monthly_value => params[:investment_declaration][:monthly_value], :yearly_value => params[:investment_declaration][:yearly_value], :employee_id => current_user.employee.id)
     redirect_to investment_declarations_path
  end
  
end
 

