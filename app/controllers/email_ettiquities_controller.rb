class EmailEttiquitiesController < ApplicationController
  
  # layout "emp_profile_template", only: [:index, :new, :create, :show]

	 before_filter :hr_view,  only: ["new", "edit"]
  before_filter :other_emp_view
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
    @emails = @employee.email_ettiquities
  end

  
  def show
    @email= EmailEttiquitie.find(params[:id])
  end

  
	def destroy
		@employee = Employee.find(params[:employee_id])
		@email= EmailEttiquitie.find(params[:id])
		@emails = @employee.email_ettiquities
	end
	

end



  
  
