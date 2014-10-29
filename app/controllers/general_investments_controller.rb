class GeneralInvestmentsController < ApplicationController

  def new
    @investment = GeneralInvestment.new
    
  end
  
  def create
  @investment = GeneralInvestment.create(general_investment_params)
  redirect_to  section_declarations_path
  end
  
  def edit
   @investment = GeneralInvestment.find(params[:id])
  end
  
  def update
    @investmet = GeneralInvestment.find(params[:id])
    @investmet.update(general_investment_params)
    redirect_to  section_declarations_path
  end
  
 private 
 
 def general_investment_params
   params.require(:general_investment).permit(:title, :description, :section_declaration_id) 
 end
 
end



