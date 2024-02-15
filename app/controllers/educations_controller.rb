 class EducationsController<Controller                       
                                             
 # helper class included                                                                                                                    
 include EducationsHelper                                                                                                                                                                                                                                                                       
                                                                                                                                                                  
   layout "emp_profile_template", only: [:index, :new, :create, :show, :edit, :update]                            
   before_filter :hr_view,  only: ["new", "edit"]                                              
   before_filter :other_emp_view                                        
                        
  def index         
    @employee = Employee.find(params[:employee_id])     
    @educations =  Education.where(:Employee_id => params[:employee_id])              
  end   
       
  def new
    @education = Education.new
    @employee = Employee.find(params[:employee_id])
  end
                                                          
  def create                             
    @new_education = Education.create(params.require(:education).permit(:specilization, :institute, :year_of_admission, :year_of_pass, :cgpa_percentage).merge(Employee_id: params[:employee_id]))
    @errors = @new_education.errors.full_messages
    # raise @errors.inspect     
    #for new form              
    @employee = Employee.find(params[:employee_id])    
    @education = Education.new
    @list =  Education.where(:Employee_id => params[:employee_id])
    @form_type = params[:commit]
    #EducationQualification.create(:qualification_id => @qualification_id, :education_id => @education.id)
  end
     
  def show      
    # show method                 
  end                         
                                               
  def edit                                                                                                  
    # raise params.inspect                                                                                                                                                                                                                                                                                                                                                 
    @employee = Employee.find(params[:employee_id])                                                                                        
    @education = Education.find(params[:id])                                                                                                                                                                                                                      
  end                                                        
  
  def update 
    @employee = Employee.find(params[:employee_id])
    @education = Education.find(params[:id])
    #raise params.inspect
    if @education.update(params.require(:education).permit(:specilization, :institute, :year_of_admission, :year_of_pass, :cgpa_percentage))
    redirect_to employee_educations_path(@employee.id)
    else
    render 'edit'
  end
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
 # raise params.inspect    
redirect_to employee_educations_path(@employee)
end
 
end
