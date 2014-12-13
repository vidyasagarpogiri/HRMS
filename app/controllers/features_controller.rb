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
       @features = Feature.all 
    end
  end
  
end
