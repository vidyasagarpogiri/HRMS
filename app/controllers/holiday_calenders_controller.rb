class HolidayCalendersController < ApplicationController

  layout "leave_template"
def index
      #raise params.inspect
      @group = Group.find(params[:group_id])
      @holiday_calenders =@group.holiday_calenders
    end
    
    def new
    #raise params.inspect
      @holiday_calender = HolidayCalender.new
      @group = Group.find(params[:group_id])
    end
    
    def create
      #raise params.inspect
       @group = Group.find(params[:group_id])
       params_with_group = params_calender.merge(group_id: params[:group_id])
       
       @holiday_calender = HolidayCalender.new(params_with_group)
        if @holiday_calender.save
      
          redirect_to group_path(@group)
       
        else
          flash.now[:error] 
          render "new"
        end
           
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
      params.require(:holiday_calender).permit(:event_id, :mandatory_or_optional)
    end
end
