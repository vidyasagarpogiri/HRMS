class ProfileController<Controller                                                                                                
                                                                                        
  layout "emp_profile_template"                                              
                                                                                                                                                                                                                     
  before_filter :hr_view, :only => [ :edit]                                                                                                   
                                                                                                                                                                                                                                              
  def edit                                                                                                                                                                                                                                                                                                                                                                                           
    if params[:id].present?                                                                                                                                             
      @employee = Employee.find(params[:id])                                                                                                     
    else                                      
      @employee = Employee.new                                                  
    end                                                               
    @address = Address.new   
  end                                                        
end
                    
                  
