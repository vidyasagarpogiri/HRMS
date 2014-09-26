class ExperiencesController < ApplicationController

  #layout "emp_profile_template", only: [:index, :new, :create, :show, :edit, :update]
  before_filter :hr_view,  only: ["new", "edit"]
  before_filter :other_emp_view
  
  def index
    @employee = Employee.find(params[:employee_id])
    @experiences = @employee.experiences
  end
  
  def new 
    @experience = Experience.new
    @employee = Employee.find(params[:employee_id])
  end
   
  def create
    #raise params.inspect
    @new_experience = Experience.create(params.require(:experience).permit(:previous_company, :last_designation, :from_date, :to_date).merge(employee_id: params[:employee_id]))
   @errors = @new_experience.errors.full_messages
    
    #for new form 
    @employee = Employee.find(params[:employee_id])
    @experience = Experience.new
    @experiences = @employee.experiences
    @form_type = params[:commit]
  end
  
  def show
    
  end
  
  def edit
    @employee = Employee.find(params[:employee_id])
    @experience = Experience.find(params[:id])
  end
  

  
  def update
    @employee = Employee.find(params[:employee_id])
    @experience = Experience.find(params[:id])
    @experience.update(params.require(:experience).permit(:previous_company, :last_designation, :from_date, :to_date))
   @experiences = @employee.experiences
  end
		
	def destroy
		@employee = Employee.find(params[:employee_id])
    @experience = Experience.find(params[:id])
		@experience.destroy
		@experiences = @employee.experiences
	end
  
end
