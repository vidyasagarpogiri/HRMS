class GenericInvestmentDeclarationsController < ApplicationController

  def index
    @generic_investments = GenericInvestmentDeclaration.all
  end
  
  def new
    @generic_investment = GenericInvestmentDeclaration.new
  end
  
  def create
     @generic_investment = GenericInvestmentDeclaration.create(generic_investment_params)
     redirect_to generic_investment_declarations_path
  end
  
  def edit
    @generic_investment = GenericInvestmentDeclaration.find(params[:id])
  end
  
  def update
    @generic_investment = GenericInvestmentDeclaration.find(params[:id])
    @generic_investment.update(generic_investment_params)
     redirect_to generic_investment_declarations_path
  end

private

 def generic_investment_params
  params.require(:generic_investment_declaration).permit(:section, :title, :maximum_limit, :description) 
 end
end


