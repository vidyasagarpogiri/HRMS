class EmailEttiquitiesController < ApplicationController
  
  layout "profile_template", only: [:index, :new, :create, :show]

	def index
    @emails = EmailEttiquitie.all
  end

  def new
    @email = EmailEttiquitie.new
		@employee= Employee.find(params[:employee_id])
  end
  
  def create
    @email = EmailEttiquitie.create(:ettiquite => params[:email_ettiquitie][:ettiquite], :dateofsending=>params[:email_ettiquitie][:dateofsending],:employee_id => params[:employee_id])
		@email.save
		redirect_to employee_email_ettiquity_path(@email.employee, @email)
  end

  def show
    @email= EmailEttiquitie.find(params[:id])
  end
  
  def edit
  end
  
end



  
  
