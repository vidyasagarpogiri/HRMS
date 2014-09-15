class EmployeesController < ApplicationController

layout "emp_profile_template", only: [:show, :show_exit, :edit, :exit_edit_form]

  def index
    @employees =  Employee.all.page(params[:page]).per(2)
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
     @employee.update(:user_id => @user.id)
      redirect_to @employee
    end
    
  end

  def show
    @employee = Employee.find(params[:id])
    @reporting_manager = Employee.find(@employee.reporting_managers.first.manager_id).full_name if @employee.reporting_managers.present?
  end

  def profile
     @employee = Employee.find(params[:id])
  end
  
  def edit
    @employee = Employee.find(params[:id])
  end
  
  def update
    @employee = Employee.find(params[:id])
    if @employee.update(params_employees) 
      @report = @employee.reporting_managers.first
      if @report.present?
        @report.update(:manager_id => params[:reporting_id]) 
      else
        @report = ReportingManager.create(:employee_id => @employee.id, :manager_id => params[:reporting_id])
      end  
		  redirect_to @employee
		else
		  render 'edit'
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
  
	def show_exit
		
		@employee = Employee.find(params[:id])
			
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
	
  private
   
 
  def params_employees
    params.require(:employee).permit(:employee_id, :title, :first_name, :last_name, :date_of_birth, :gender, :marital_status, :total_experience, :status, :mobile_number, :father_name, :pan, :date_of_confirmation, :date_of_join, :date_of_exit, :department_id, :blood_group_id, :ff_status_id, :designation_id, :grade_id, :role_id, :group_id, :alternate_email, :avatar, :job_location_id)
  end
	

end


