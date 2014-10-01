class StaticSalariesController < ApplicationController
  def new
    @static_salary = StaticSalary.new
    @static_salaries = StaticSalary.all 
  end
  
  def create
   @salaries = params[:salary]  
   #raise @salaries.inspect
   @salaries.each do |s|
    #raise s[1][:name].inspect
    @static_salary = StaticSalary.create(:name => s[1][:name], :value => s[1][:value])
   end
   redirect_to allowances_path
   end
end
