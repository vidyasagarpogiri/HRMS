class GroupsController<Controller                                                                                                
                                                      
  layout "leave_template"                                                                                                                                                                                                             
                                                                                                            
  before_filter :other_emp_view                                                                                                                   
                                                                                                                                                                                                                                                                                                           
  def index                                                                                                                                                                                                                                                          
    @groups = Group.all                                                                                                                                                                                                               
  end                                                                                                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                                                                                                                                                                                                                          
  def new                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    @group = Group.new                                                                                                                                                                                                                                                                                                                                                       
  end                                                                                                                                                                                                    
                                                                                                                                                             
  def edit                                                     
     @group = Group.find(params[:id])                                                                                                                                                                     
     @reporting_manager = ReportingManager.find_by                              
  end                                                                   
                         
end    
       
