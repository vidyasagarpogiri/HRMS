class EducationsController < ApplicationController
 include EducationsHelper
   #layout "emp_profile_template", only: [:index, :new, :create, :show, :edit, :update]
  before_filter :hr_view,  only: ["new", "edit"]
  before_filter :other_emp_view
  before_action :find_employee, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :find_education_details, only: [:show, :edit, :update, :destroy]
  
  def index
    @educations =  @employee.educations
  end
  
  def new
    @education = Education.new
  end
  
  def create     
    @new_education = Education.create(params.require(:education).permit(:specilization, :institute, :year_of_admission, :year_of_pass, :cgpa_percentage).merge(Employee_id: params[:employee_id]))
    @errors = @new_education.errors.full_messages
    @education = Education.new    
    @educations =  @employee.educations
    @form_type = params[:commit] 
  end
  
  def show    
  end
  
  def edit
  end
    
  def update
    @education.update(params.require(:education).permit(:specilization, :institute, :year_of_admission, :year_of_pass, :cgpa_percentage))
    @educations =  @employee.educations
    @errors = @education.errors.full_messages
  end

  def qualifications
    respond_to do |format|
      format.json  { render :json => getQualificationList }
    end
  end

 	def destroy
		@education.destroy
		 @educations =  @employee.educations
  end
   
  private
  def find_employee
    @employee = Employee.find(params[:employee_id])
  end
  
  def find_education_details
    @education = Education.find(params[:id])
  end
end
