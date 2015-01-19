# This Controller for Adding Policies
class PoliciesController < ApplicationController
 # before_filter :role_auth

  def role_auth
    actions = role_based_auth(params[:controller], params[:action])
    if actions.present?
      @edit_permission = true if actions.include?("edit")
      @new_permission = true if actions.include?("new")
      @delete_permission = true  if actions.include?("delete")
    else
      render text: "You Don`t Have Permission"
    end
  end

  public

  def index
    @policies = Policy.all.page(params[:page]).per(4)
  end

  def new
    @policy = Policy.new
  end

  def create
    @policy = Policy.new(policy_params)
    if @policy.save
      Employee.where(status: false).each do |emp|
        #Notification.delay.policy_notification(emp.user, @policy)
      end
      redirect_to policies_path
    else
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
