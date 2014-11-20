class GroupsController < ApplicationController 

   before_filter :hr_view
   before_action :get_group, only: [:show, :edit, :update, :add_employee, :update_employee]
  
  def index
    @groups = Group.all
  end
  
  def new  
    @group = Group.new     
  end 
  
  def create 
    @group = Group.create(group_params)
    redirect_to  groups_path
  end
  
  def show   
     @employees = @group.employees
     @leave_policy = @group.leave_policy
     @holiday_calenders = @group.holiday_calenders
     @leaves = @employees.order("created_at DESC").map(&:leave_histories).flatten if @employees.present?  
  end
  
  def edit          
  end
  
  def update  
    @group.update(group_params)
    redirect_to  @group    
  end
  
  def add_employee
    @employees = Employee.all    
  end
  
  def update_add_employee      
      @employee = Employee.find(params[:employee_id])      
      @employee.update(:group_id => @group.id)
      redirect_to @group
  end

	def holiday_list
		@holidays = current_user.employee.group.holiday_calenders
		@leave_policy = current_user.employee.group.leave_policy
		@group = current_user.employee.group
	end
  
  def holiday_notification
    @group= Group.find(params[:id])
    @events = @group.holiday_calenders.map(&:event)
    @employees = @group.employees.where(status: false)
    @employees.each do |emp|
    Notification.holiday_list(emp.user,@events,@group).deliver
    end
   redirect_to @group
  end
  
  private
  def group_params
     params.require(:group).permit(:group_name)     
  end
  
  def get_group
    @group = Group.find(params[:id])
  end
  
end
