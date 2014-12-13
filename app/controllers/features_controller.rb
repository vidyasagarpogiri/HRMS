class FeaturesController < ApplicationController

  def index

    unless params[:designation].present? 
      @role = Role.where(:department_id => current_user.employee.department_id, :designation_id => current_user.employee.designation_id).first
    else
      @role = Role.where(:designation_id => params[:designation]).first
    end
    if params[:controllers].present?
       @features = @role.features.where(:controller => params[:controllers])
       @controller = params[:controllers]
    else
       @features = @role.features 
    end
   
  end
  
  def features_configure
     unless params[:designation].present? 
      @role = Role.where(:department_id => current_user.employee.department_id, :designation_id => current_user.employee.designation_id).first
    else
      @role = Role.where(:designation_id => params[:designation]).first
    end
    if params[:controllers].present?
       @features = Feature.where(:controller => params[:controllers])
       @controller = params[:controllers]
    else
       @features = Feature.where(:controller => "AddressesController")
       @controller = Feature.first.controller
    end
  end
  
  def create_package
  #TODO have to refactor
    @role = Role.find(params[:role])
    @controller = params[:controllers]
    
    if params[:feature_ids].present?
      a = @role.features.where(controller: @controller).map(&:id)
      b=[]
       params[:feature_ids].each do |feature_id|
        b << feature_id.to_i
       end
      removed_features = (a-b)
      removed_features.each do |feature_id|
        Package.where(role_id: params[:role], feature_id: feature_id).first.delete if Package.where(role_id: params[:role], feature_id: feature_id).first.present?
      end
    end
    
    if params[:new_feature_ids].present?
      params[:new_feature_ids].each do |feature_id|
        Package.create(role_id: params[:role], feature_id: feature_id)
      end
    end
    redirect_to features_path
  end
  
end
