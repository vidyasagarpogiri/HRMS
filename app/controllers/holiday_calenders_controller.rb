class HolidayCalendersController < ApplicationController
 before_filter :hr_view,  only: ["new", "edit"]
  before_filter :other_emp_view
 # layout "leave_template"
def index
      #raise params.inspect
      @department = Group.find(params[:department_id])
      @holiday_calenders =@department.holiday_calenders
    end
    
    def new
    #raise params.inspect
      @holiday_calender = HolidayCalender.new
      @department = Department.find(params[:department_id])
      @events = Event.all
    end
    
    def create
      #raise params.inspect
      @department = Department.find(params[:department_id])
      #TODO - BalaRaju - Have to modify this condition 
      @department.holiday_calenders.destroy_all
      if  params[:event_ids].present? 
        params[:event_ids].each do |event|
          if  params[:mandatory].present?
            if params[:mandatory].include?(event)
            #raise params[:mandatory].inspect
              @holiday_calender =  @department.holiday_calenders.create( event_id: event, mandatory_or_optional: true)
       
            else
              @holiday_calender = @department.holiday_calenders.create( event_id: event, mandatory_or_optional: false)
            end 
         else
            @holiday_calender = @department.holiday_calenders.create( event_id: event, mandatory_or_optional: false)
         end
        end
    end
       @holiday_calenders = @department.holiday_calenders
      # raise @holiday_calenders.inspect
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
    end
    
    private
    def params_calender
      #params.require(:holiday_calender).permit(:mandatory_or_optional)
    end
end
