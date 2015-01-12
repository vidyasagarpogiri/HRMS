class FfStatusesController < ApplicationController
	before_filter :hr_view,  only: ["new", "edit"]
  before_filter :other_emp_view
  before_action :get_employee, only: [:index, :new, :create, :show, :edit, :update]
  before_action :get_ff_status, only: [:show, :edit, :update]
  
  def index     
     @status = @employee.ff_status
  end
  
	def new
		@status = FfStatus.new
	end
	
	def create
		@status = FfStatus.create(status_params)
		  @employee.update(:ff_status_id => @status.id, :employment_status => 'F&F')
		  @status = @employee.ff_status
	end
	
	def show		
	end	
	
	def edit
  end
	
	def update		
		@status = @employee.ff_status
		if @status.update(status_params)
	    @status = @employee.ff_status
	  end 
	end	
	
	private
	def status_params
		params.require(:ff_status).permit(:date_of_exit, :summary, :interview_status, :status_name)
	end
	
	def get_employee
	  @employee = Employee.find(params[:employee_id])
	end
	
	def get_ff_status
	  @status = FfStatus.find(params[:id])
	end
end
