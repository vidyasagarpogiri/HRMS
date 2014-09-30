class EducationsController < ApplicationController

 include EducationsHelper
  
   #layout "emp_profile_template", only: [:index, :new, :create, :show, :edit, :update]
   before_filter :hr_view,  only: ["new", "edit"]
   before_filter :other_emp_view
  
  def index
    @employee = Employee.find(params[:employee_id])
    @educations =  @employee.educations
  end
  
  def new
    @education = Education.new
    @employee = Employee.find(params[:employee_id])
  end
  
  def create
     
    @new_education = Education.create(params.require(:education).permit(:specilization, :institute, :year_of_admission, :year_of_pass, :cgpa_percentage).merge(Employee_id: params[:employee_id]))
    @errors = @new_education.errors.full_messages

    #for new form 
    @employee = Employee.find(params[:employee_id])
    @education = Education.new
    
     @educations =  @employee.educations
    @form_type = params[:commit]
    #EducationQualification.create(:qualification_id => @qualification_id, :education_id => @education.id)
  
  end
  
  def show
    
  end
  
  def edit
    @employee = Employee.find(params[:employee_id])
    @education = Education.find(params[:id])
  end
  

  
  def update
    @employee = Employee.find(params[:employee_id])
    @education = Education.find(params[:id])
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
		@employee = Employee.find(params[:employee_id])
    @education = Education.find(params[:id])
		@education.destroy
		 @educations =  @employee.educations
  end
  

end
