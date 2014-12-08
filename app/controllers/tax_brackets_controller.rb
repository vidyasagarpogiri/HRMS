# We are using Tax Bracket Controller for TDS Calucaltions 
class TaxBracketsController < ApplicationController
  
  def index
    @tax_brackets = TaxBracket.all
  end
  
  def new
    @tax_bracket = TaxBracket.new
  end
  
  def create
    @tax_bracket = TaxBracket.new(params_tax_bracket)
    if @tax_bracket.save
      redirect_to tax_brackets_path 
    else
      render "new", :locals => { :@custom_error => "Upper limit must be greater than lower limit" }
    end
  end
  
  def edit
    @tax_bracket = TaxBracket.find(params[:id])
  end
  
  def update
    @tax_bracket = TaxBracket.find(params[:id])
    if @tax_bracket.update(params_tax_bracket)
      redirect_to tax_brackets_path 
    else
      render "edit", :locals => { :@custom_error => "Upper limit must be greater than lower limit" }
    end
  end
  
  def show
       
  end
  
  private
  
  def params_tax_bracket
    params.require(:tax_bracket).permit(:bracket, :lower_limit, :upper_limit, :tax_percentage, :min_tax) 
  end
end
