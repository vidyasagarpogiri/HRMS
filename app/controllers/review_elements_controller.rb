class ReviewElementsController < ApplicationController
  
  def index
    @review_elements = ReviewElement.all
  end
  
  def new
    @review_element = ReviewElement.new
  end
  
  def create
    @review_element = ReviewElement.create(review_element_params)
    @review_elements = ReviewElement.all
  end
  
  private
  
  def review_element_params
    params.require(:review_element).permit(:review_element, :performance_indicator, :employee_assesment, :employee_rating, :manager_feedback, :manager_rating)
  end
end
