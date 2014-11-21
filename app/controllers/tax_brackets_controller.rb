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
      #redirect_to 
    else
    end
  end
  
end
