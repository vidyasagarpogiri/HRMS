class EmployeesController < ApplicationController

  layout "emp_profile_template", only: [:show, :show_exit, :edit, :exit_edit_form, :attachment_form_new, :attachment_show, :attachment_index, :attachment_edit] 
	 before_filter :other_emp_view, :except => [:index, :profile, :getAllSkills]
	 before_filter :hr_view, :only => [:create, :new, :edit, :update, :exit_edit_form, :exit_form, :update_exit_form, :attachment_form_new, :attachment_destroy, :attachment_edit, :show_exit, :attachment_update]		
   before_action :get_employee, only: [:show, :profile, :edit, :update, :exit_form, :attachment_form_new, :attachment_create, :attachment_edit, :attachment_update, :attachment_show, :attachment_destroy, :attachment_index, :bankdetails_form, :bankdetails_create,:bankdetails_show, :bankdetails_edit, :bankdetails_update	]
  
  def index
    @employees =  Employee.where(:status => false)
    #@skills = current_user.employee.skills.map(&:name)
    #raise @skills.inspect
  end

  def new
    @employee = Employee.new
  end
  
  def create
    @employee = Employee.create(params_employees)  
    if @employee.errors.present?
      render 'new'
    else
     @reporting_manager = ReportingManager.create(:employee_id => @employee.id, :manager_id => params[:reporting_id])     
     @user = User.invite!(:email =>  params[:email], :skip_invitation => true)
     @employee.update(:user_id => @user.id, :status => false)
     redirect_to profile_path(@employee)
    end   
  end

  def show
    if @employee.reporting_managers.first.present? &&  @employee.reporting_managers.first.manager_id.present? 
      unless @employee.reporting_managers.first.manager_id == 0 
        @reporting_manager = Employee.find(@employee.reporting_managers.first.manager_id).full_name 
      end
    end
 
  end

  def profile
  #raise @employee.inspect
     if @employee.educations.present?
      @specialization = @employee.educations.order('year_of_pass DESC').first
     end
     if @employee.projects.present?
       @projects = @employee.projects
      # raise @projects.inspect
     end
     
      if @employee.skills.present?
       @skills = @employee.skills
      # raise @projects.inspect
     end
     
  end
  
  def edit
  end
  
  def update    
    if params[:employee].present? 
      @employee.update(params_employees) 
      @report = @employee.reporting_managers 
        if @report.present?
          @report = @report.first
          @report.update(:manager_id => params[:reporting_id])          
        else
          @report = ReportingManager.create(:employee_id => @employee.id, :manager_id => params[:reporting_id])
        end  
      @errors = @employee.errors.full_messages     
    end         
  end  

	def exit_edit_form
	end

	def exit_form
		if !@employee.nil?
		  redirect_to show_exit_employee_path(@id)
		end
	end

	def update_exit_form
			@employee.update(:date_of_exit=>params[:employee][:date_of_exit],:ff_status_id=> params[:employee][:ff_status_id])
			redirect_to show_exit_employee_path(@employee.id)
	end
  
  def attachment_form_new
   @emp_get_attachements = @employee.employee_attachments
    @emp_get_attachements = [] if Employee.find(params[:id]).employee_attachments.nil?
    @employee = Employee.find(params[:id])
    @employee_attachments = @employee.employee_attachments.build  
  end

  def attachment_create 
     if params["employee_attachments"].present?
      if params["employee_attachments"]["attachment"].present? 
      params["employee_attachments"]["attachment"].each_with_index do |a, i|
        @employee_attachment = @employee.employee_attachments.create!(:attachment => a, :attachment_name => params["employee_attachments"]["attachment_name"][i], :employee_id => @employee.id)       
      end   
    end
  end
     @errors = @employee_attachment.errors.full_messages
     @emp_get_attachments  = @employee.employee_attachments
  end
	
	def attachment_edit
	  @emp_attachement = EmployeeAttachment.find(params[:attachment_id])
	end
	
	 def attachment_update
	    @emp_attachement = EmployeeAttachment.find(params[:attachment_id])
	    @emp_attachement.update(:attachment_name=> params[:employee_attachments][:attachment_name])
	    redirect_to attachment_show_employee_path(@employee,@employee_attachement)
	 end
	
	def show_exit		
		@employee = Employee.find(params[:id])			
	end

  def attachment_show
	 @emp_get_attachements = @employee.employee_attachments
  end

  def attachment_destroy
		@emp_get_attachements = EmployeeAttachment.find(params[:attachment_id])
 		@emp_get_attachements.destroy
     @emp_get_attachments  = @employee.employee_attachments
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
			
	def attachment_index
    @emp_get_attachments = @employee.employee_attachments	
  end
    	
	def bankdetails_index
    @bank_details =  @employee.bank_detail
  end
  
  def bankdetails_form
    @bank_details = Employee.new    
  end
  
  def bankdetails_create
		@bank_details = @employee.update(:bank_name => params[:bank_name], :branch_name => params[:branch_name], :account_number => params[:account_number] , :pan => params[:pan], :PFAccountNumber => params[:PFAccountNumber])	
		if @employee.errors.present?
      render 'bankdetails_form'	
    end
	end
  
  def bankdetails_show
		emp_id = params[:id] if params[:id].present?
		@employee = Employee.find(emp_id)		
	end	
	
	def bankdetails_edit
  end
	
	def bankdetails_update	
		@bank_details = @employee.update(:bank_name => params[:bank_name], :branch_name => params[:branch_name], :account_number => params[:account_number] , :pan => params[:pan], :PFAccountNumber => params[:PFAccountNumber])		
	end
	
	#inactive employees code
	def inactive_employees
    @employees =  Employee.where(:status => true).page(params[:page]).per(4)
	end
	
	  # employee Self-description 
  
  def employee_self_description_show
    
    @employee = current_user.employee
    @skills = @employee.skills.map(&:name)
   # raise @employee.self_description.inspect
  end
    
  def employee_self_description_form
    @employee = current_user.employee
    @skills = @employee.skills.map(&:name)   
  end
  
  def employee_self_description_create
    @employee = Employee.find(params[:id])
    skills_exist = @employee.skills.map(&:name) 
    skills = params[:hidden_skill].split(", ").uniq 
    new_skills = skills - (skills&skills_exist)
    new_skills.each do |skill|
      skill_id = Skill.find_by_name(skill)
      #raise skill_id.inspect
     @employee.skills << skill_id
    end
    @employee.update(:self_description => params[:self_description], :interests => params[:interests])
    @skills = @employee.skills.map(&:name).uniq 
  end
	
	
		def getAllSkills 
      skill=Skill.where("name LIKE ?", "%#{params[:term]}%").map(&:name)
      render json:skill
	  end
	  
	  def my_workgroups # for work groups of employee
	     @employee = current_user.employee 
	     workgroups = @employee.workgroups # workgroups in which current employee is a member 
	     workgroups1 = Workgroup.where(admin_id: @employee.id) # workgroups which are created by current employee
	     @workgroups=(workgroups+workgroups1).uniq # total work groups of current employee    
	  end
	  
  private   
 
  def params_employees
    params.require(:employee).permit(:employee_id, :title, :first_name, :last_name, :date_of_birth, :gender, :marital_status, :total_experience, :status, :mobile_number, :father_name, :pan, :date_of_confirmation, :date_of_join, :date_of_exit, :department_id, :blood_group_id, :ff_status_id, :designation_id, :grade_id, :role_id, :group_id, :alternate_email, :avatar, :job_location_id, :employment_status, 
    :shift_id,:devise_id, employee_attachments_attributes: [:id, :employee_id, :attachment])
  end
  
  def attachment_employees
    params.require(:employee_attachements).permit(employee_attachments_attributes: [:id, :employee_id, :attachment, :attachment_name])
  end
	
	def bank_details
    params.require(:bank_details).permit(:bank_name, :account_number, :branch_name, :pan, :PFAccountNumber)
  end
  
  def get_employee
    @employee = Employee.find(params[:id])
  end        	
end

