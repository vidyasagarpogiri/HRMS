class EmailEttiquitiesController < ApplicationController

	def index
    @emails = EmailEttiquitie.all
  end

  def new
    @email = EmailEttiquitie.new
  end
  
  def create
    @email = EmailEttiquitie.create(:ettiquite => params[:email_ettiquitie][:ettiquite], :dateofsending=>params[:employee][:dateofsending])
		@email.save
		redirect_to @email
  end

  def show
    @email= EmailEttiquitie.find(params[:id])
  end
  
  def edit
  end
  
end



  
  
