class StaticSalariesController < ApplicationController

  def index
    @static_salaries = StaticSalary.all 
    respond_to do |format|
      format.json { render json: @static_salaries }
    end 
  end
  def new
    @static_salary = StaticSalary.new
    @static_salaries = StaticSalary.all 
  end
  
  def create
  
   @static_salaries = StaticSalary.all 
   @salaries = params[:salary]  
   #raise @salaries.inspect
   if @salaries.present?
   @salaries.each do |s|
    @static_salary = StaticSalary.find(s[0].to_i)
    @static_salary.update(:value => s[1][:value])
   end
   else
    flash[:notice]= "Please configure salaries"
   end
  
   redirect_to static_allowances_path
   end
end
