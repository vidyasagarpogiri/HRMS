class DepartmentsController < ApplicationController
 #layout "leave_template", only: [:leaves, :index, :employee_leaves, :holiday_list]
  before_filter :hr_view
  before_filter :hr_admin_view, only: [:new, :edit]
  before_action :find_department, only: [:show, :edit, :department, :add_employee, :update_employee, :update ]

  def index
    @departments = Department.all
    respond_to do |format|
      format.html
      format.json { render json: @departments }
    end
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.create(department_params)
    redirect_to @department
  end

  def show
    @employees = @department.employees
		@designations = @department.designations
		@leaves = @employees.order("created_at DESC").map(&:leave_histories).flatten if @employees.present?
		@appraisal = Appraisal.find(@department.appraisal_id) if @department.appraisal_id.present?
  end

  def edit          
    # this action using for adding appraisal template to department - sekhar 
  end
  
  def update
    @department.update(appraisal_id: params[:department][:appraisal_id])
    @appraisal = Appraisal.find(@department.appraisal_id)
  end
  
  def destroy
		@department.destroy
		redirect_to @department
	end
	
	def add_employee
    @employee = Employee.all
  end
  
  def update_employee 
    @employee = Employee.find(params[:employee_id])
    @employee.update(:department_id => @department.id)
    redirect_to @department
  end

=begin
code not required but for future use   
  def leaves
    @department = Department.find(params[:id])
    @employees = @department.employees
    @holiday_calenders = @department.holiday_calenders
  end 
   
  def employee_leaves  
    @dept = Department.find(params[:id])
    @employees = @dept.employees
    @leaves = @employees.order("created_at DESC").map(&:leave_histories).flatten if @employees.present?
  end
  

  def holiday_list
		@department = current_user.employee.department
	end
=end  

  private
  def department_params
    params.require(:department).permit(:department_name) 
  end
  def find_department
     @department = Department.find(params[:id])   
  end
end
