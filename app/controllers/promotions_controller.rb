class PromotionsController < ApplicationController
  
  layout "profile_template", only: [:index, :new, :create, :edit, :update]

	def index
	  @employee = Employee.find(params[:employee_id])
    @promotions = @employee.promotions
  end
	
  def new
    @promotion = Promotion.new
		@employee = Employee.find(params[:employee_id])
  end
    
	def create
		#raise params.inspect
    @promotion = Promotion.create(:date_of_promotion=> params[:promotion][:date_of_promotion], :employee_id=>params[:employee_id],
		:designation_id=>params[:promotion][:designation_id])                      
    @promotion.save
    redirect_to employee_promotions_path
  end
  
  def edit
    @employee = Employee.find(params[:employee_id])
    @promotion = Promotion.find(params[:id])
  end
  
  def update
    #raise params.inspect
    @employee = Employee.find(params[:employee_id])
    @promotion = Promotion.find(params[:id])
    @promotion.update(:date_of_promotion=> params[:promotion][:date_of_promotion], :designation_id=>params[:promotion][:designation_id] )
    redirect_to employee_promotions_path
  end
  def destroy
		@employee = Employee.find(params[:employee_id])
    @promotion = Promotion.find(params[:id])
		@promotion.destroy
		redirect_to employee_promotions_path(@employee)
	end
     
 
end


  
