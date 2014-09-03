class HolidayCalenderController < ApplicationController
  
    def index
      @holidayCalenders = HolidayCalanders.all
    end
    
    def new
      @holidayCalender = HolidayCalanders.new
      @group = Group.find(params[:group_id])
    end
    
    def create
       @group = Group.find(params[:group_id])
       @holidayCalender = HolidayCalanders.create(params_calender)
           
    end
    
    def edit
    end
    
    def show
    end
    
    private
    def params_calender
      params.require(:holiday_calanders).permit(:date, :event, :mandatory_or_optional)
    end
    
end
