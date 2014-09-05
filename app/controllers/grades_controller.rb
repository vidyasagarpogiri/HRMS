class GradesController < ApplicationController

  def index
    @grades = Grade.all
  end

  def new
    @grade = Grade.new
  end

  def create
    @grade = Grade.create(grade_params)
    redirect_to @grade
  end

  def show
    @grade = Grade.find(params[:id])
    @employees = @grade.employees

  end

  def update
    @grade = Grade.find(params[:id])
    @grade.update(grade_params)
    redirect_to @grade
  end
  
  def edit     
    @grade = Grade.find(params[:id])        
  end
  
  def destroy
	  @grade = Grade.find(params[:id])
		@grade.destroy
		redirect_to @grade
	end
	
    
  private
  def grade_params
    params.require(:grade).permit(:value) 
  end
end

