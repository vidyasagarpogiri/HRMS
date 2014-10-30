class CompanyPayRollMastersController < ApplicationController

  def index
    @pay_rolls = CompanyPayRollMaster.all    
  end
  

end
