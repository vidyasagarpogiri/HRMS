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
   @recruitment = Recruitment.create(recruitment_params)
   @users = User.all
  
    if @recruitment.present?
      #raise  @users.inspect
      #Notification.job_notification(@users,@recruitment).deliver
      @users.each do |user|
      Notification.delay.job_notification(user,@recruitment)
      end 	
       #raise Notification.delay.job_notification(@users,@recruitment).inspect
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
    @recruitments = Recruitment.all.page(params[:page]).per(4)
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
