class ProfileController < ApplicationController
  
#layout "emp_profile_template"
  before_filter :hr_view, :only => [ :edit]
  
  
  

  def edit
   # raise params[:id].inspect
    if params[:id].present?
      @employee = Employee.find(params[:id])
    else
      @employee = Employee.new 
    end 
    @address = Address.new
  end
  
  def show
    @employee = Employee.find(params[:id])
  end
  
end
