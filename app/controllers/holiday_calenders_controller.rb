class HolidayCalendersController < ApplicationController
 before_filter :hr_view,  only: ["new", "edit"]
 before_filter :other_emp_view
 
 def index
   @group = Group.find(params[:group_id])
   @holiday_calenders = @group.holiday_calenders
 end    
    
 def new
   @holiday_calender = HolidayCalender.new
   @group = Group.find(params[:group_id])
    @events = Event.all
 end
    
 def create
   @group = Group.find(params[:group_id])
   #TODO - BalaRaju - Have to modify this condition 
   @group.holiday_calenders.destroy_all
   if  params[:event_ids].present? 
    params[:event_ids].each do |event|
     if params[:mandatory].present?
       if params[:mandatory].include?(event)
         @holiday_calender =  @group.holiday_calenders.create( event_id: event, mandatory_or_optional: true)      
       else
          @holiday_calender = @group.holiday_calenders.create( event_id: event, mandatory_or_optional: false)
       end 
      else
        @holiday_calender = @group.holiday_calenders.create( event_id: event, mandatory_or_optional: false)
      end
     end
   end
   @holiday_calenders = @group.holiday_calenders
  end
    
  def edit
    @group = Group.find(params[:group_id])
    @holiday_calender = HolidayCalender.find(params[:id])
  end
      
  def update
    @group = Group.find(params[:group_id])
    @holiday_calender = HolidayCalender.find(params[:id])
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
