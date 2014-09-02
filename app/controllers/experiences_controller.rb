class ExperiencesController < ApplicationController

  layout "profile_template", only: [:index, :new, :create, :show, :edit, :update]
  
  def index
     @employee = Employee.find(params[:employee_id])
     @experinces = @employee.experiences
  end
  
  def new 
    @experience = Experience.new
    @employee = Employee.find(params[:employee_id])
  end
   
  def create
    #raise params.inspect
    @new_experience = Experience.new(params.require(:experience).permit(:previous_company, :last_designation, :from_date, :to_date).merge(employee_id: params[:employee_id]))
    @new_experience.save
    
    #for new form 
    @employee = Employee.find(params[:employee_id])
    @experience = Experience.new
    
    @list =  Experience.where(:Employee_id => params[:employee_id])
    @form_type = params[:commit]
  end
  
  def show
    
  end
  
  def edit
    #raise params.inspect
    @employee = Employee.find(params[:employee_id])
    @experience = Experience.find(params[:id])
  end
  

  
  def update
    #raise params.inspect
    @employee = Employee.find(params[:employee_id])
    @experience = Experience.find(params[:id])
    @experience.update(params.require(:experience).permit(:previous_company, :last_designation, :from_date, :to_date))
    redirect_to employee_experiences_path(@employee.id)
  end
  
end
