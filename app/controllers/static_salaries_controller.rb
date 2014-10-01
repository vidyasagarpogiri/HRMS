class StaticSalariesController < ApplicationController

  def index
    @static_salaries = StaticSalary.all  
  end
  def new
    @static_salary = StaticSalary.new
    @static_salaries = StaticSalary.all 
  end
  
  def create
  
   @static_salaries = StaticSalary.all 
   @salaries = params[:salary]  
   #raise @salaries.inspect
   @salaries.each do |s|
    @static_salary = StaticSalary.find(s[0].to_i)
    @static_salary.update(:value => s[1][:value])
   end
   redirect_to allowances_path
   end
end
