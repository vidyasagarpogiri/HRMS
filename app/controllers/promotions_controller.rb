class PromotionsController < ApplicationController

	def index
    @promotions = Promotion.all
  end
	
  def new
    @promotion = Promotion.new
  end
    
	def create
    @promotion = Promotion.new(params.require(:promotion).permit(:date_of_promotion, :employee_id , :designation_id))
    @promotion.save
    redirect_to @promotion
  end
     
  def show
  #raise params.inspect
    @promotion = Promotion.find(params[:id])
  end
     
  
private
  def promotion_params
    params.require(:promotion).permit(:date_of_promotion, :employee_id , :designation_id)
  end
end

