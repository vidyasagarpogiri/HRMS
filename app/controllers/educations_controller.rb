class EducationsController < ApplicationController

 include EducationsHelper
  
   layout "profile_template", only: [:index, :new, :create, :show, :edit, :update]
  
  
  def index
    @employee = Employee.find(params[:employee_id])
    @eudcations =  Education.where(:Employee_id => params[:employee_id])
  end
  
  def new
    @education = Education.new
    @employee = Employee.find(params[:employee_id])
  end
  
  def create
  
    #raise params[:employee_id].inspect
    #country_id = if params[:new_country].present?
    #                @country = Country.new(:country_name => params[:new_country])
    #               @country.save
    #              @country.id
    #              else
    #                params[:ed_country]
    #              end
    #state_id = if params[:new_state].present?
    #                @state = State.new(:state_name => params[:new_state], :country_id => country_id)
    #                @state.save
    #                @state.id
    #              else
    #                params[:ed_state]
    #              end
    #city_id = if params[:new_city].present?
    #                @city = City.new(:city_name => params[:new_city], :state_id => state_id)
    #                @city.save
    #                @city.id
    #              else
    #                params[:ed_city]
    #              end
    #@qualification_id = if params[:qualification].present?
    #                      @qualification = Qualification.new(:qualification_name => params[:qualification])
    #                      @qualification.save
    #                      @qualification.id
    #                    else
    #                      params[:qulification_id]
    #                    end
    @new_education = Education.new(params.require(:education).permit(:specilization, :institute, :year_of_admission, :year_of_pass, :cgpa_percentage).merge(Employee_id: params[:employee_id]))
    @new_education.save
     
  
    
    #for new form 
    @employee = Employee.find(params[:employee_id])
    @education = Education.new
    
    @list =  Education.where(:Employee_id => params[:employee_id])
    @form_type = params[:commit]
    #EducationQualification.create(:qualification_id => @qualification_id, :education_id => @education.id)
  
  end
  
  def show
    
  end
  
  def edit
    #raise params.inspect
    @employee = Employee.find(params[:employee_id])
    @education = Education.find(params[:id])
  end
  

  
  def update
    #raise params.inspect
    @employee = Employee.find(params[:employee_id])
    @education = Education.find(params[:id])
    @education.update(params.require(:education).permit(:specilization, :institute, :year_of_admission, :year_of_pass, :cgpa_percentage))
    redirect_to employee_educations_path(@employee.id)
  end

  def qualifications
    respond_to do |format|
      format.json  { render :json => getQualificationList }
    end
  end

 	def destroy
		@employee = Employee.find(params[:employee_id])
    @education = Education.find(params[:id])
		@education.destroy
		redirect_to employee_educations_path(@employee)
	end
  

end
