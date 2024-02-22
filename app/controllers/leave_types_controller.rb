    class LeaveTypesController<Controller        
 
 before_filter :hr_view,  only: ["new", "edit"]                                                                                             
 before_filter :other_emp_view                                                                                                                                    
 layout "leave_template"                                                                                                                                                 
                                                                                                                                                                                                               
  def index                                                                                                                                                                                                                                                                                                                                 
    @leave_types = LeaveType.all                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
  end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
                                                                                                                                                                                                
  def new                                                                                                                                                                                           
    @leave_type = LeaveType.new                                                                                                                                                                      
  end                                                                                 
                         
  def create 
  # raise params.inspect
    @leave_type = LeaveType.create(parama_leave_types)                             
    @leave_type.save                               
    redirect_to leave_types_path
  end                                                
 
  def edit                                                           
   # raise params.inspect                                 
    @leave_type = LeaveType.find(params[:id])
  end            
                  
  def update                                   
   # raise params.inspect
    @leave_type = LeaveType.find(params[:id])
    @leave_type.update(parama_leave_types)                                                           
    redirect_to leave_types_path              
  end                                                                                                        
                                              
  def show                                                                                                                                               
    # raise params.inspect                                                                                                                                                                                                                                                                                     
  end                                                                                      
                                                                                                                                                                                                                                                                                                                                                                                      
 def destroy                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
    #raise params.inspect                                                                                                                
    @leave_type = LeaveType.find(params[:id])                         
    @leave_type.destroy               
    redirect_to leave_types_path
  end
 
  private
  
  def parama_leave_types
    params.require(:leave_type).permit(:type_name)
  end
                 
end             
