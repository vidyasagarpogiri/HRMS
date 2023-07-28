  class HolidayCalendersController<Controller                                                                                         
  before_filter :hr_view,  only: ["new", "edit"]     
  before_filter :other_emp_view                                  
  layout "leave_template"                                                                                                           
                                                                                                                                                                      
def index                                                                                                                                                                                            
   @department = Group.find(params[:department_id])                                                                                                                                                                                                                                                                
   @holiday_calenders =@department.holiday_calenders                                                                                                                                                                                                                                                                                        
 end                                                                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                                                    
  def new                                                                                                                                                                                             
    @holiday_calender = HolidayCalender.new                                                                                                                                      
    @department = Department.find(params[:department_id])                                                                                                                               
    @events = Event.all                                                                                
  end  
    
    def create                          
      @department = Department.find(params[:department_id])
      #TODO              
      @department.holiday_calenders.destroy_all   
      params[:event_ids].each do |event|               
      if params[:mandatory].include?(event) 
      # raise params[:mandatory].inspect                 
        @holiday_calender = HolidayCalender.create(department_id: @department.id, event_id: event, mandatory_or_optional: true)
      else
        @holiday_calender = HolidayCalender.create(department_id: @department.id, event_id: event, mandatory_or_optional: false)
      end              
    end                  
       redirect_to leaves_department_path(@department)                     
    end 
                                                  
    def edit                               
     # raise params.inspect                      
     @group = Group.find(params[:group_id])                
     @holiday_calender = HolidayCalender.find(params[:id])                           
    end                                                                                     
                                                             
    def update                                                                                                                                                      
     # raise params.inspect                                                                                                                        
      @group = Group.find(params[:group_id])                                                                                      
      @holiday_calender = HolidayCalender.find(params[:id])
      #raise params.inspect
      params_with_group = params_calender.merge(group_id: params[:group_id])
      @holiday_calender.update(params_with_group)
      redirect_to group_path(@group)
    end
    
    def show
     #raise params[:mandatory].inspect
    end
    
    private 
    def params_calender
      #params.re      
    end
  end
