class InvestmentDeclarationsController < ApplicationController
  
  def index
    @generic_declarations = GenericInvestmentDeclaration.all
    g_ids = @generic_declarations.map(&:id)
    i_ids = InvestmentDeclaration.all.map(&:generic_investment_declaration_id)
    remaining_ids = g_ids-i_ids
    remaining_ids.each do |id|
      InvestmentDeclaration.create(generic_investment_declaration_id: id, monthly_value: 0, yearly_value: 0, employee_id: current_user.employee.id )
    end
    @declarations = InvestmentDeclaration.all
  end
  
  def edit
    @declaration = InvestmentDeclaration.find(params[:id])
  end
  
  def update
    @declaration = InvestmentDeclaration.find(params[:id])
    #raise params[:investment_declaration][:monthly_value].inspect
     @declaration.update(:generic_investment_declaration_id =>  @declaration.generic_investment_declaration_id, :monthly_value => params[:investment_declaration][:monthly_value], :yearly_value => params[:investment_declaration][:yearly_value], :employee_id => current_user.employee.id)
     redirect_to investment_declarations_path
  end
  
end
 

