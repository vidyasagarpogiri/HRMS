  class EmployeesController< Controller                                                                    
                                              
  layout "emp_profile_template", only: [:show, :show_exit, :edit, :exit_edit_form, :attachment_form_new, :attachment_show, :attachment_index, :attachment_edit]
	                               
	  #before_filter :other_emp_view, :except => [:index, :profile]                                                                                          
                                                         
	  #before_filter :hr_view, :only => [:create, :new, :edit, :update, :exit_edit_form, :exit_form, :update_exit_form, :attachment_form_new, :attachment_destroy, :attachment_edit, :show_exit, :attachment_update]	
                                       
  def index                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
    @employees =  Employee.all.page(params[:page]).per(6)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
  end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
           
  def new                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
    @employee = Employee.new                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                                                                                                                                                                
     @reporting_manager = ReportingManager.create(:employee_id => @employee.id, :manager_id => params[:reporting_id])                                                                                                                                                                                                                     
     @user = User.invite!(:email =>  params[:email], :skip_invitation => true)                                                                                                                                                                                                        
     @employee.update(:user_id => @user.id)                                                                                                                                                                                                                                             
      redirect_to @employee                                                                                                          
    end                                                                                                                                
                                                                                                                                                                              
  end                                                    
                                                                            
  def show                                                                                                     
    @employee = Employee.find(params[:id])                                                                       
    if @employee.reporting_managers.first.present? &&  @employee.reporting_managers.first.manager_id.present?              
      unless @employee.reporting_managers.first.manager_id == 0     
        @reporting_manager = Employee.find(@employee.reporting_managers.first.manager_id).full_name                
      end                                                               
    end                                                                                                      
  end                                                                                         
                                                                                                                              
  def profile                                                                                                                  
     @employee = Employee.find(params[:id])                              
     if @employee.educations.present?                               
     @specialization = @employee.educations.order('year_of_pass DESC').first    
     end                                           
  end                                   
  
  def edit                                                     
    @employee = Employee.find(params[:id])                       
  end           
         
  def update                         
        
    @employee = Employee.find(params[:id])
   
    if params["employee_attachments"].present?                                   
      if params["employee_attachments"]["attachment"].present? 
      params["employee_attachments"]["attachment"].each_with_index do |a, i|
      #raise a.inspect
        @employee_attachment = @employee.employee_attachments.create!(:attachment => a, :attachment_name => params["employee_attachments"]["attachment_name"][i], :employee_id => @employee.id)
        
      end
        
        
    end
       redirect_to attachment_show_employee_path(@employee)
    end                           
    
    if params[:employee].present? 
    
      if @employee.update(params_employees)  
        @report = @employee.reporting_managers
        if @report.present?
          @report.update_all(:manager_id => params["employee"][:reporting_id])          
        else
          @report = ReportingManager.create(:employee_id => @employee.id, :manager_id => params["employee"][:reporting_id])
        end  
      redirect_to @employee
		  else		
		    render 'edit'
      end     
    end
  end  

	def exit_edit_form
		@employee = Employee.find(params[:id])
	end

	def exit_form
		@employee = Employee.find(params[:id])
		if !@employee.nil?
		  redirect_to show_exit_employee_path(@id)  
		end
	end      

	def update_exit_form
			@employee = Employee.find(params[:id])                  
			@employee.update(:date_of_exit=>params[:employee][:date_of_exit],:ff_status_id=> params[:employee][:ff_status_id])
			redirect_to show_exit_employee_path(@employee.id)
	end
  

  
  def attachment_form_new                  
   @emp_get_attachements = Employee.find(params[:id]).employee_attachments
    @emp_get_attachements = [] if Employee.find(params[:id]).employee_attachments.nil?
    @employee = Employee.find(params[:id])
    @employee_attachments = @employee.employee_attachments.build
    #raise params.inspect
    #redirect_to @attachment
   
  end
                 
   def attachment_destroy
    @employee = Employee.find(params[:id])
		@emp_get_attachements = EmployeeAttachment.find(params[:attachment_id])
 		@emp_get_attachements.destroy
		redirect_to attachment_form_new_employee_path(@employee)
	end
	
	def attachment_edit
	  #raise params.inspect                 
	  @employee = Employee.find(params[:id])
	  #raise params.inspect
	  @emp_attachement = EmployeeAttachment.find(params[:attachment_id])
	  #raise @emp_attachement.inspect
		#@emp_attachement.update(:attachment=>params[:attachment],:attachment_name=> params[:attachment_name])
	end
	
	 def attachment_update
	 #raise params.inspect
	    @employee = Employee.find(params[:id])
	    @emp_attachement = EmployeeAttachment.find(params[:attachment_id])
	    @emp_attachement.update(:attachment_name=> params[:employee_attachments][:attachment_name])
	    #raise @emp_attachement.inspect
	    redirect_to attachment_show_employee_path(@employee,@employee_attachement)
	 end
	 
	def show_exit
		
		@employee = Employee.find(params[:id])
			
	end

def attachment_show
	#raise params.inspect
	 @employee = Employee.find(params[:id])
	 #raise @employee.inspect
	 @emp_get_attachements = Employee.find(params[:id]).employee_attachments
	 #raise @emp_get_attachements.inspect
end
	
	def myprofile        
	  @employee = current_user.employee
	  @emp = @employee
	  @id = @employee.id
		@education_details = @employee.educations
		@experience_details = @employee.experiences
		@address = Address.find(@employee.present_address_id) if @employee.present_address_id.present?
		@promotions = @employee.promotions
		@salary = @employee.salary
	if @salary.present?
		@allowances = @salary.allowances
		@insentives = @salary.insentives
		@increments = @salary.salary_increments
end
		 @emails = @employee.email_ettiquities
	end
	
	
	def getAllEmployees  
	  data = Employee.all.pluck(:id,:first_name, :last_name)
	  json_data = []
	  
	  data.each do|val|
	    json_data << {"id"=>val[0], "value" => "#{val[1]} #{val[2]}" }
	  end
	  
	  respond_to do |format|
      format.json { render json: json_data }
    end
	end
	
  private
   
 
  def params_employees
    params.require(:employee).permit(:employee_id, :title, :first_name, :last_name, :date_of_birth, :gender, :marital_status, :total_experience, :status, :mobile_number, :father_name, :pan, :date_of_confirmation, :date_of_join, :date_of_exit, :department_id, :blood_group_id, :ff_status_id, :designation_id, :grade_id, :role_id, :group_id, :alternate_email, :avatar, :job_location_id, employee_attachments_attributes: [:id, :employee_id, :attachment])
  end
  
  def attachment_employees
    params.require(:employee_attachements).permit(employee_attachments_attributes: [:id, :employee_id, :attachment, :attachment_name])
  end
	
	
   
end


