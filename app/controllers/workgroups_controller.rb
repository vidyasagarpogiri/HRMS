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
    @employees = @workgroup.employees
    @employee = current_user.employee

  end
  
  def edit
    @workgroup = Workgroup.find(params[:id])
  end
  
  def update
    @workgroup = Workgroup.find(params[:id])
    @workgroup.update(params_workgroup)
    redirect_to workgroups_path
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
  #raise params.inspect
    @employee = Employee.find(params[:member_id])
    @workgroup = Workgroup.find(params[:id])
    unless @workgroup.employees.map(&:employee_id).include?(@employee.id.to_s)
      WorkgroupsEmployee.create(employee_id: @employee.id, workgroup_id: @workgroup.id)
    end
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
  
  private
  
  def params_workgroup 
    params.require(:workgroup).permit(:name, :description, :workgroupicon).merge(:admin_id => current_user.employee.id)
  end
end
