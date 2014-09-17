class ProfileController < ApplicationController
  
layout "emp_profile_template"
  before_filter :hr_view, :only => [ :edit]
  
  def layout_method
    if params[:id].present?
      self.class.layout "profile_template"
    else
      self.class.layout "newprofile_template"
    end
     
  end
  
  
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
