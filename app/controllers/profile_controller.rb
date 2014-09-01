class ProfileController < ApplicationController
  
  layout "profile_template"
  
  def edit
   # raise params[:id].inspect
    if params[:id].present?
      @employee = Employee.find(params[:id])
    else
      @employee = Employee.new 
    end 
    @address = Address.new
  end
  
end
