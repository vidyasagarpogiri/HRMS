class TaxFormsController < ApplicationController
  
  def index
    @tax_forms = current_user.employee.pay_roll_masters
  end
  
  def show
    @tax_form = PayRollMaster.find(params[:id])
  end
  
end
