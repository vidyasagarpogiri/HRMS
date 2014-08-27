class PromotionsController < ApplicationController

	def index
    @promotions = Promotion.all
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
    redirect_to employee_promotion_path(@promotion.employee, @promotion)
  end
     
  def show
  #raise params.inspect
    @promotion = Promotion.find(params[:id])
  end
     
 
end


  
