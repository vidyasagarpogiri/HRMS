class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :empId
  
  
  def after_sign_in_path_for(resource)
    employees_path
  end 

  def after_sign_up_path_for(resource)
     employees_path
  end
  
  
  
  private
  def empId
  
    resource, id = request.path.split('/')[1,2]
    @id= id
    if resource == "employees" && id.present?
      @emp = Employee.find(id) 
    end

  end
end
