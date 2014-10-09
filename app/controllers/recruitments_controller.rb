class RecruitmentsController < ApplicationController
  before_filter :hr_view,  only: ["new", "edit"]
  def index
   @recruitments = Recruitment.all.page(params[:page]).per(4)
  end
  
  def new
   @recruitment = Recruitment.new
  end
  
  def create
  #raise params.inspect
   @recruitment = Recruitment.new(recruitment_params)
  
    if @recruitment.save
      redirect_to recruitments_path
    else
       flash.now[:error]
       render "new"
    end
  end
  
  def edit
    @recruitment = Recruitment.find(params[:id]) 
  end
  
  def show
    @recruitment = Recruitment.find(params[:id])
    @recruitments = Recruitment.all
  end
  
  def update
    @recruitment = Recruitment.find(params[:id])
     if @recruitment.update(recruitment_params)
        redirect_to recruitments_path
      else
       flash.now[:error]
       render "edit"
    end   
  end
  
  def destroy
    @recruitment =  Recruitment.find(params[:id])
    @recruitment.destroy
    redirect_to recruitments_path 
  end
  
  
  private
  
  def recruitment_params
     params.require(:recruitment).permit(:jobcode, :title, :description, :link, :status, :file ) 
  end
  
end
