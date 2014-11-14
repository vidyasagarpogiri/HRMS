class EmailEttiquitiesController < ApplicationController  
  # layout "emp_profile_template", only: [:index, :new, :create, :show]
	before_filter :hr_view,  only: ["new", "edit"]
  before_filter :other_emp_view
  before_action :find_employee, only: [:index, :new, :create, :destroy]
  before_action :find_email_ettiquitie, only: [:show, :destroy]
	
	def index
    @emails = @employee.email_ettiquities
  end

  def new
    @email = EmailEttiquitie.new		
  end
  
  def create
    @email = EmailEttiquitie.create(:ettiquite => params[:email_ettiquitie][:ettiquite], :dateofsending => Date.today,:employee_id => @employee.id)
    @emails = @employee.email_ettiquities
    @errors = @email.errors.full_messages
  end
  
  def show
  end
  
	def destroy
		@email.destroy
		@emails = @employee.email_ettiquities
	end
	
	private
	def find_employee
	  @employee = Employee.find(params[:employee_id])
	end
	def find_email_ettiquitie
	  @email= EmailEttiquitie.find(params[:id])
	end

end



  
  
