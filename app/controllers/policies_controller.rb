class PoliciesController < ApplicationController
  
   before_filter :hr_view,  only: ["new", "edit"]
  
 
  
  def index
   @policies = Policy.all.page(params[:page]).per(4)
  end
  
  def new
   @policy = Policy.new
  end
  
  def create
  #raise params.inspect
   @policy = Policy.new(policy_params)
   #@users = User.all
  
    if @policy.save
    #raise params.inspect
      Employee.where(status: false).each do |emp|
      #Notification.delay.policy_notification(emp.user,@policy)
      end 	
  
      redirect_to policies_path
    else
       flash.now[:error]
       render "new"
    end
  end
  
  def edit
    @policy = Policy.find(params[:id]) 
  end
  
  def show
    @policy = Policy.find(params[:id]) 
    @policies = Policy.all.page(params[:page]).per(4)
  end
  
  def update
    @policy = Policy.find(params[:id])
     if @policy.update(policy_params)
        redirect_to policies_path
      else
       flash.now[:error]
       render "edit"
    end   
  end
  
  def destroy
    @policy =  Policy.find(params[:id])
    @policy.destroy
    redirect_to policies_path 
  end
  
  
  private
  
  def policy_params
     params.require(:policy).permit(:title, :details, :document, :bootsy_image_gallery_id) 
  end
  
end 
