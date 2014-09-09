class EmailEttiquitiesController < ApplicationController
  
  layout "profile_template", only: [:index, :new, :create, :show]

	before_filter :user_authentication, only: [:index, :new, :create, :show, :edit, :update]

	def index
		#raise params.inspect
		@employee = Employee.find(params[:employee_id])
    @emails = @employee.email_ettiquities
  end

  def new
		@employee= Employee.find(params[:employee_id])
    @email = EmailEttiquitie.new
		
  end
  
  def create
		@employee = Employee.find(params[:employee_id])
    @email = EmailEttiquitie.create(:ettiquite => params[:email_ettiquitie][:ettiquite], :dateofsending => Date.today,:employee_id => @employee.id)
    if @email.save
		redirect_to employee_email_ettiquities_path(@employee)
		else 
		render 'new'
  end
  end
  
  def show
    @email= EmailEttiquitie.find(params[:id])
  end
  
  def edit
  end
  
	def destroy
		@employee = Employee.find(params[:employee_id])
		@email= EmailEttiquitie.find(params[:id])
		@email.destroy
		redirect_to employee_email_ettiquities_path(@employee.id)
	end
	
	private
	def user_authentication	
			@employee = Employee.find(params[:employee_id])
			#raise @employee.inspect
		if current_user.employee.employee_id  == @employee.employee_id && @employee.role_id == 2
		else
			redirect_to employees_path
		end
	end
end



  
  
