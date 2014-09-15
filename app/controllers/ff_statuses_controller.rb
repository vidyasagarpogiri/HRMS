class FfStatusesController < ApplicationController
	def new
		@employee = Employee.find(params[:employee_id])
		@status = FfStatus.new
	end
	
	def create
		#raise params.inspect
		@employee = Employee.find(params[:employee_id])
		@status = FfStatus.create(status_params)
		@employee.update(:ff_status_id => @status.id)
		#raise @status.inspect
		redirect_to employee_ff_status_path(@employee, @status)
	end
	
	def show
		#raise params.inspect
		@status = FfStatus.find(params[:id])
		@employee = Employee.find(params[:employee_id])
		
	end	
	
	def edit
		#raise params.inspect
		@employee = Employee.find(params[:employee_id])
		@status = FfStatus.find(params[:id])
  end
	
	def update
		
		@employee = Employee.find(params[:employee_id])
		@status = FfStatus.find(params[:id])
#raise @status.inspect
		@status.update(status_params)
		redirect_to employee_ff_status_path(@employee, @status)
	end 
	
	
	private
	def status_params
		params.require(:ff_status).permit(:date_of_exit, :summary, :interview_status, :status_name)
	end
end
