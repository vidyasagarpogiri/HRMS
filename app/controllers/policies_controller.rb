class PoliciesController < ApplicationController
  
   before_filter :hr_view,  only: ["new", "edit"]
  
 
  
  def index
   @policies = Policy.all.page(params[:page]).per(3)
  end
  
  def new
   @policy = Policy.new
  end
  
  def create
  #raise params.inspect
   @policy = Policy.new(policy_params)
  
    if @policy.save
    #raise params.inspect
      redirect_to policies_path
    else
       flash.now[:error]
       render "new"
    end
  end
  
  def edit
    @policy = Policy.find(params[:id]) 
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
