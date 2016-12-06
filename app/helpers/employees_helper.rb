module EmployeesHelper
  
  def show_errors(object, field_name)
  if object.error.any?
    if !object.errors.messages[field_name].blank?
      object.errors.messages[field_name].join(", ")
    end
  end
    
end 
end

