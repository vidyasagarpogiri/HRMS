# This controller is for workgroups # Author: Vidya Sagar Pogiris
class WorkgroupsController < ApplicationController
  
  def index
    @workgroups = Workgroup.all.page(params[:page]).per(6)  
    @employee = current_user.employee
  end
  
  def new
    @workgroup = Workgroup.new
  end
  
  def create 
    @workgroup = Workgroup.new(params_workgroup)
    if @workgroup.save
      redirect_to workgroups_path
    else
      render 'new' 
    end
  end
  
  def show
    @workgroup = Workgroup.find(params[:id])
    @admin = Employee.find_by(:employee_id => @workgroup.admin_id )
    #raise @admin.first_name.inspect
    @employees = @workgroup.employees
    @employee = current_user.employee
  end
  
  def edit
    @workgroup = Workgroup.find(params[:id])
  end
  
  def update
    @workgroup = Workgroup.find(params[:id])
    if @workgroup.update(params_workgroup)
    redirect_to workgroups_path
    else
    render 'edit'
  end
  end
  
  def destroy
    @workgroup = Workgroup.find(params[:id])
    @workgroup.destroy
    redirect_to workgroups_path
  end
  
  def add_members
    @workgroup = Workgroup.find(params[:id])
    @employee_id = @workgroup.admin_id
    #raise @employee_id.inspect
    @employees = Employee.all
    #@employee_ids = WorkgroupsEmployee.where(workgroup_id: @workgroup.id).pluck(:employee_id)
    #raise @employee_ids.inspect
  end
  
   def add_moderator
    #raise params.inspect
    @workgroup = Workgroup.find(params[:id])
    @employees = @workgroup.employees
  end
  
  def added_members
    @employee = Employee.find(params[:member_id])
    @workgroup = Workgroup.find(params[:id])
    WorkgroupsEmployee.create(employee_id: @employee.id, workgroup_id: @workgroup.id)
    redirect_to @workgroup
  end
  
  def added_moderators 
    @workgroup = Workgroup.find(params[:id])
    WorkgroupsEmployee.where(workgroup_id: @workgroup.id).each do |work| 
    work.update(is_moderator: false)
    end
    if params[:employee_ids].present?
        params[:employee_ids].each do |emp| 
        employee = Employee.find(emp)
        employee_workgroup = WorkgroupsEmployee.where(employee_id: emp, workgroup_id: @workgroup.id).each do |empwor|
        #raise employee_workgroup.inspect
        empwor.update(is_moderator: true)
        end 
    end
    end
    redirect_to @workgroup
  end
  
  def destroy_member
    #raise params.inspect
    @workgroup = Workgroup.find(params[:id])
    @employee = Employee.find(params[:employee_id])
    #WorkgroupsEmployee.last.id
    @selectedemployee = WorkgroupsEmployee.find_by(workgroup_id: @workgroup.id ,employee_id: @employee.id)
    #raise @selectedemployee.inspect
    @selectedemployee.destroy
    redirect_to @workgroup
  end
  
  def get_employees
    @workgroup = Workgroup.find(params[:id])
    workgroup_employees = @workgroup.employees 
    total_employees = Employee.where(status: false)
    employees = total_employees - workgroup_employees
    json_data = []
    employees.each do|val|
	    json_data << {"id"=>val.id, "value" => "#{val.first_name} #{val.last_name}" }
	  end
    respond_to do |format|
      format.json { render json: json_data }
    end
  end
  
  private
  
  def params_workgroup 
    params.require(:workgroup).permit(:name, :description, :workgroupicon).merge(:admin_id => current_user.employee.id)
  end
end
