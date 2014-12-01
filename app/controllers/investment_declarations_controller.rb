class InvestmentDeclarationsController < ApplicationController
  
  before_filter :find_assesment_year 
  
  def index 
    employee = current_user.employee
    InvestmentDeclaration.create_new_investment(employee, @assesment_year)
    
    @declarations = employee.investment_declarations.where(assesment_year: @assesment_year)
    @sections = @declarations.map(&:general_investment).map(&:section_declaration).uniq
    
    @sum_of_declarations = InvestmentDeclaration.sum_of_declation(employee, @assesment_year) 
    PayRollMaster.form_16_create_or_update(employee, @assesment_year, @sum_of_declarations)
    
  end
  
  def edit
    @declaration = InvestmentDeclaration.find(params[:id])
  end
  
  def update
    employee = current_user.employee
    @declaration = InvestmentDeclaration.find(params[:id])
    @declaration.update(:general_investment_id =>  @declaration.general_investment_id, 
                        :yearly_value => params[:investment_declaration][:yearly_value], 
                        :employee_id => employee.id)
    @sum_of_declarations = InvestmentDeclaration.sum_of_declation(employee, @assesment_year) 
    @declarations = employee.investment_declarations.where(assesment_year: @assesment_year)
    PayRollMaster.form_16_create_or_update(employee, @assesment_year, @sum_of_declarations)
    redirect_to investment_declarations_path
  end
  
  private 
  
  def find_assesment_year
    month = Date.today.month
    year = Date.today.year
    @assesment_year = month > 3 ? year : year - 1 
  end
  
end

