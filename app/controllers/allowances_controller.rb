class AllowancesController < ApplicationController
  #layout "profile_template", only: [:index, :new, :create, :show, :update]
  
  before_action :find_allowance, only: [:show, :edit, :update, :destroy]
 
 
 def index
  @allowances = Allowance.all
  @static_salaries = StaticSalary.all
 end
 
 def new
   @allowance = Allowance.new
 end
 
 def create
  value = params[:value].to_f
  if params[:allowance_type].to_i == 1
    @allowance = Allowance.create(:allowance_name => params[:allowance][:allowance_name], :value => value)
  else
    @allowance = Allowance.create(:allowance_name => params[:allowance][:allowance_name], :allowance_value => value)  
  end
  redirect_to allowances_path
 end
 
 def show
    
 end
 
 def edit

 end
 
 def update
   value = params[:value].to_f
  if params[:allowance_type].to_i == 1
    @allowance.update(:allowance_name => params[:allowance][:allowance_name], :value => value, :allowance_value => nil)
  else
    @allowance.update(:allowance_name => params[:allowance][:allowance_name], :allowance_value => value, :value => nil)  
  end
  redirect_to allowances_path
 end
	
	def destroy
	@allowance.destroy
	redirect_to allowances_path
	end
 
 private
 
  def find_allowance
    @allowance = Allowance.find(params[:id])
  end
  
end
