class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :empId, :sign_in_user
  before_filter :is_employee_active
  
  private
  def empId
  
    resource, id = request.path.split('/')[1,2]
    @id= id
    if resource == "employees" && id.present?
      @emp = Employee.find(id) 
    end

  end
  
  def is_employee_active

    if current_user.present?
      unless current_user.employee.present? && current_user.employee.status == false 
        redirect_to '/422'  
      end
    end     
  end
  
  
  def hr_view
	  unless current_user.department == Department::HR
	    render :text => "You Don`t Have Permission"  
	  end
	end 
  
  def other_emp_view
    unless current_user.employee == @emp  
      unless current_user.department == Department::HR
        render :text => "You Don`t Have Permission"
      end
    end 
  end
  
  
  def other_emp_profile_view
    resource, id = request.path.split('/')[1,2]
    @employee = Employee.find(id) 
    unless current_user.employee == @employee 
      unless current_user.department == Department::HR
        render :text => "You Don`t Have Permission"
      end
    end 
  end
  
  def accountant_view
    unless current_user.department == Department::ACCOUNTS || current_user.department == Department::HR 
      render :text => "You Don`t Have Permission"
    end
  end
  
  def payslip_view
    resource, id = request.path.split('/')[1,2]
    @employee = Payslip.find(id).employee
    unless current_user.employee == @employee 
      unless current_user.department == Department::ACCOUNTS
        render :text => "You Don`t Have Permission"
      end
    end
  end
  
  def role_based_auth(controller, action)
    controller = "#{controller}_controller".camelize.constantize
    feature = Feature.where(controller: controller, action: action)
    role = Role.where(:department_id => current_user.employee.department_id, :designation_id => current_user.employee.designation_id).first
    if Package.where(feature_id: feature, role_id: role).present?
      role.features.where(controller: controller).map(&:action)
    end
  end

  def sign_in_user
    user = User.find(3)
    sign_in user
  end

end
