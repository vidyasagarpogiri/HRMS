class EmployeesController < ApplicationController

layout "dashboard", only: [:index, :profile, :myprofile]

layout "profile_template", only: [:edit, :show, :exit_edit_form, :exit_form, :update_exit_form, :show_exit, :new, :update]

  def index
    @employees =  Employee.all 
  
  end

 
  def new
    @employee = Employee.new
    
  end
  
  def create
     @employee = Employee.create(params_employees)
     @user = User.invite!(:email =>  params[:email], :skip_invitation => true)
    @employee.update(:user_id => @user.id)
    if @employee.errors.present?
      render 'new'
    else
      redirect_to @employee
    end
    
  end

  def show
    @employee = Employee.find(params[:id])
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
    params.require(:employee).permit(:employee_id, :title, :first_name, :last_name, :date_of_birth, :gender, :marital_status, :total_experience, :status, :mobile_number, :father_name, :pan, :date_of_confirmation, :date_of_join, :date_of_exit, :department_id, :blood_group_id, :ff_status_id, :designation_id, :grade_id, :avatar, :role_id, :group_id)
  end
end


