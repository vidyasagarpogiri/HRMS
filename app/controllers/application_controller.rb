class Controller   < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception
  before_filter :empId             
  
                                                        
  private
  
  def empId
    resource, id = request.path.split('/')[1,2]                   
    @id= id
    if resource == "employees" && id.present?
      @emp = Employee.find(id)                                              
    end
                               
  end
                   
  def hr_view
    unless current_user.department == Department::HR
    render :text => "You Dont Have Permission"  
    end
  end 
  
  def other_emp_view
    unless current_user.employee == @emp  
      unless current_user.department == Department::HR
        render :text => "You Dont have permission"
      end
    end 
  end
  
end                                     
                                           
          
       
             
