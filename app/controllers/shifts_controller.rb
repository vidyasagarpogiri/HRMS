class ShiftsController < ApplicationController

  before_filter :hr_admin_view, only: [:new, :edit, :destroy]
  
  def index
    @shifts = Shift.all
  end
  
  def new
   @shift = Shift.new
  end
  
  def create
  #raise params.inspect
   @shift = Shift.new(shift_params)
     if @shift.save
    #raise params.inspect
      redirect_to shifts_path
 	      else
          render 'new'
      end
  end
  
  def edit
    @shift = Shift.find(params[:id]) 
  end
  
  def show
    @shift = Shift.find(params[:id]) 
    @shifts = Shift.all
  end
  
  def update
    @shift = Shift.find(params[:id])
     if @shift.update(shift_params)
        redirect_to shifts_path
      else
        render 'edit'
    end   
  end
  
  def destroy
    @shift =  Shift.find(params[:id])
    @shift.destroy
    redirect_to shifts_path 
  end
  
  private
  
  def shift_params
   params.require(:shift).permit(:name, :from_time, :to_time, :is_next_day)
  end
  
end
