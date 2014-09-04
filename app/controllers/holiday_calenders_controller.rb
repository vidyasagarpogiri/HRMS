class HolidayCalendersController < ApplicationController
def index
      @group = Group.find(params[:group_id])
      @holiday_calanders =HolidayCalender.all
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
       @holiday_calender = HolidayCalender.create(params_with_group)
       redirect_to group_path(@group)
           
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
      params.require(:holiday_calender).permit(:date, :event, :mandatory_or_optional)
    end
end
