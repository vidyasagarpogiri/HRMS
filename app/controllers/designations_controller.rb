class DesignationsController < ApplicationController

  def index
    @designations = Designation.all
  end

  def new
    @designation = Designation.new
  end

  def create
    @designation = Designation.create(designation_params)
    redirect_to @designation
  end

  def show
    #raise params.inspect
    @designation = Designation.find(params[:id])
    @employees = @designation.employees
    @grades = @designation.grades

  end

  def update
    @designation = Designation.find(params[:id])
    @designation.update(designation_params)
    redirect_to @designation
  end
  
  def edit     
    @designation = Designation.find(params[:id])        
  end
  
  def destroy
	  @designation = Designation.find(params[:id])
		@designation.destroy
		redirect_to @designation
	end
	
  def add_employee
    @designation = Designation.find(params[:id])
    @employee = Employee.all
  end
   def update_employee
    @designation = Designation.find(params[:id])
    @employee = Employee.find(params[:employee_id])
    @employee.update(:designation_id => @designation.id)
    #raise @employee.inspect
    redirect_to @designation
   end 
    
  private
  def designation_params
    params.require(:designation).permit(:designation_name, :email) 
  end
end


