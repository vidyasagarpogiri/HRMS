class PromotionsController < ApplicationController
  

	  before_filter :hr_view, :only => [:create, :new, :edit, :update]	
	 before_filter :other_emp_view
#layout "emp_profile_template", only: [:index, :new, :create, :show, :edit, :update]

	def index
	  @employee = Employee.find(params[:employee_id])
    @promotions = @employee.promotions
  end
	
  def new
    @promotion = Promotion.new
		@employee = Employee.find(params[:employee_id])
		
  end
    
	def create
		@employee = Employee.find(params[:employee_id])    
		@promotion = Promotion.create(:date_of_promotion=> params[:promotion][:date_of_promotion], :employee_id=>params[:employee_id],
		:designation_id=>params[:promotion][:designation_id], :department_id => params[:promotion][:department_id], :grade_id => params[:promotion][:grade_id])                 
		@employee.update(:designation_id => @promotion.designation_id, :department_id => @promotion.department_id, :grade_id => @promotion.grade_id)
		@promotions = @employee.promotions
    @errors = @promotion.errors.full_messages
  end
  
  def edit
    @employee = Employee.find(params[:employee_id])
    @promotion = Promotion.find(params[:id])
  end
  
  def update
    #raise params.inspect
    @employee = Employee.find(params[:employee_id])
    @promotion = Promotion.find(params[:id])
    @promotion.update(:date_of_promotion=> params[:promotion][:date_of_promotion], :employee_id=>params[:employee_id],
		:designation_id=>params[:promotion][:designation_id], :department_id => params[:promotion][:department_id], :grade_id => params[:promotion][:grade_id])
		@employee.update(:designation_id => @promotion.designation_id, :department_id => @promotion.department_id, :grade_id => @promotion.grade_id)                 
    @promotions = @employee.promotions
    @errors = @promotion.errors.full_messages
  end
  
  
  def destroy
		@employee = Employee.find(params[:employee_id])
    @promotion = Promotion.find(params[:id])
		@promotion.destroy
		@promotions = @employee.promotions
	end

	private
	def user_authentication	
			@employee = Employee.find(params[:employee_id])
			#raise @employee.inspect
		if current_user.employee.employee_id  == @employee.employee_id || current_user.employee.role_id == 2
		else
			redirect_to employees_path
		end
	end
     
 
end


  
