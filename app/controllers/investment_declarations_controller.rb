class InvestmentDeclarationsController < ApplicationController

  def index
    @declartions = InvestmentDeclaration.all
    @employee = Employee.find(params[:employee_id])
  end

  def create
    @declaration = InvestmentDeclaration.new(declaration_params)
    @employee = Employee.find(params[:employee_id])
    if  @declaration.save
      redirect_to investment_declarations_path
    else
      render "new"
    end
  end

  def new
    @declartion = InvestmentDeclaration.new
    @employee = Employee.find(params[:employee_id])
  end

  def update
  end

  def destroy
  end
  
  private
  
  def declaration_params
     params.require(:declartion).permit(:section, :title, :max_limit, :description, :monthly_value, :yearly_value) 
  end
end

  
