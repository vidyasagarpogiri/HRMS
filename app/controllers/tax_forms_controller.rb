class TaxFormsController < ApplicationController
  
  def index
    @tax_forms = current_user.employee.pay_roll_masters.order("assesment_year DESC")
  end
  
  def show
    @tax_form = current_user.employee.pay_roll_masters.find_by(assesment_year: params[:assesment_year])
    
  end
  
end
