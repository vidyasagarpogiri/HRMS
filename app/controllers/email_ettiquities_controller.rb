class EmailEttiquitiesController < ApplicationController
  
  layout "profile_template", only: [:index, :new, :create, :show]

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
    @email = EmailEttiquitie.create(:ettiquite => params[:email_ettiquitie][:ettiquite], :dateofsending=>params[:email_ettiquitie][:dateofsending],:employee_id => @employee.id)
		redirect_to employee_email_ettiquities_path(@employee)
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
end



  
  
