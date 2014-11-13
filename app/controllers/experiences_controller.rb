class ExperiencesController < ApplicationController

  #layout "emp_profile_template", only: [:index, :new, :create, :show, :edit, :update]
  before_filter :hr_view,  only: ["new", "edit"]
  before_filter :other_emp_view
  before_action :get_employee, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :get_experience, only: [:edit, :update, :destroy]
  
  def index
    @experiences = @employee.experiences
  end
  
  def new 
    @experience = Experience.new
    @employee = Employee.find(params[:employee_id])
  end
   
  def create
    @new_experience = Experience.create(params.require(:experience).permit(:previous_company, :last_designation, :from_date, :to_date).merge(employee_id: params[:employee_id]))
   @errors = @new_experience.errors.full_messages
    if @errors.present?
      render 'new'
    end
    @experiences = @employee.experiences
  end
  
  def show   
  end
  
  def edit
  end
    
  def update
   @experiences = @employee.experiences
   @experience.update(params.require(:experience).permit(:previous_company, :last_designation, :from_date, :to_date))
   @errors =  @experience.errors.full_messages
    if @errors.present?
      render 'edit'
    end
   @experiences = @employee.experiences
  end
		
	def destroy
		@experience.destroy
		@experiences = @employee.experiences
	end
	
	private
	def get_employee
	  @employee = Employee.find(params[:employee_id])
	end
	
	def get_experience
	  @experience = Experience.find(params[:id])
	end
  
end
