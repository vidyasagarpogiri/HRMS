class ProfileController < ApplicationController
 before_filter :hr_view, :only => [ :edit, :new]
 before_filter :other_emp_profile_view, only: [:show]
 
  def new
    @employee = Employee.new 
  end
  
  def edit
    if params[:id].present?
      @employee = Employee.find(params[:id])
    else
      @employee = Employee.new 
    end 
    @address = Address.new
  end
  
  def show 
    @employee = Employee.find(params[:id])
    @experiences = @employee.experiences
    @educations =  @employee.educations
    @promotions = @employee.promotions
    @emails = @employee.email_ettiquities
    @status = @employee.ff_status
    @address1 = @employee.addresses.where(:address_type=>0).first
		@address2 = @employee.addresses.where(:address_type=>1).first
    @salary = @employee.salary   
    if @salary.present?
       @allowances = @salary.allowances
    else 
       @salary = Salary.new
    end
    @report = @employee.reporting_managers.first
    @emergency = @employee.emergency_contacts
    @emp_get_attachments = @employee.employee_attachments
    @projects = @employee.projects
    @skills = @employee.skills
  end
  
end
