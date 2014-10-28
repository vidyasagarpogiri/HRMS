class GenericInvestmentDeclarationsController < ApplicationController

  def index
    @generic_investments = GenericInvestmentDeclaration.all
  end
  
  def new
    @generic_investment = GenericInvestmentDeclaration.new
    
  end
  
  def create
    
  end

private

 def generic_investment_params
  params.require(:generic_investment).permit() 
 end
end
