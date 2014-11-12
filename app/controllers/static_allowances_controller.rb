class StaticAllowancesController < ApplicationController
 before_action :get_allowance, only: [:show, :edit, :update, :destroy]
 
 def index
  @allowances = StaticAllowance.all
  @static_salaries = StaticSalary.all
 end
 
 def new
   @allowance = StaticAllowance.new
 end
 
 def create
  value = params[:value].to_f
  if params[:allowance_type].to_i == 1
    @allowance = StaticAllowance.create(:name => params[:static_allowance][:name], :percentage => value, :is_deductable => params[:static_allowance][:is_deductable])
  else
    @allowance = StaticAllowance.create(:name => params[:static_allowance][:name], :value => value, :is_deductable => params[:static_allowance][:is_deductable])  
  end
  redirect_to static_allowances_path
 end
 
 def show    
 end
 
 def edit
 end
 
 def update
   value = params[:value].to_f
  if params[:allowance_type].to_i == 1
    @allowance.update(:name => params[:static_allowance][:name], :percentage => value, :value => nil, :is_deductable => params[:static_allowance][:is_deductable])
  else
    @allowance.update(:name => params[:static_allowance][:name], :percentage => nil, :value => value, :is_deductable => params[:static_allowance][:is_deductable])  
  end
  redirect_to static_allowances_path
 end
	
	def destroy
	@allowance.destroy
	redirect_to static_allowances_path
	end
 
 private
 
  def get_allowance
    @allowance = StaticAllowance.find(params[:id])
  end
  
end
