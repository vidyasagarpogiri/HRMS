class FfStatusesController<Controller                                                                                                                   
	
  before_filter :hr_view,  only: ["new", "edit"]                                                                               
  before_filter :other_emp_view                                                                                                                                 
                                                                                 
layout "emp_profile_template", only: [:index, :new, :create, :show, :edit, :update    
                                                                                                            
  def index                                                                                                              
     @employee = Employee.find(params[:employee_id])                                                                  
     @status = @employee.ff_status                                                        
    # raise @statuses.inspect                              
  end                                       
	def new                  
		@employee = Employee.find(params[:employee_id])                     
		@status = FfStatus.new                                    
	end
	
	def create
		#raise params.inspect
		@employee = Employee.find(params[:employee_id])
		@status = FfStatus.new(status_params)
		if @status.save
		@employee.update(:ff_status_id => @status.id)
		#raise @status.inspect
		redirect_to employee_ff_statuses_path(@employee)
		else
		render 'new'
	end
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
		if @status.update(status_params)
		redirect_to employee_ff_statuses_path(@employee)
		else
		render 'edit'
	end 
	end
	
	
	private
	def status_params
		params.require(:ff_status).permit(:date_of_exit, :summary, :interview_status, :status_name)
	end
end
