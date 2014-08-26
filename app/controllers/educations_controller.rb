class EducationsController < ApplicationController
  
  include AddressHelper
  
  before_action :find_education, only: [:show, :edit, :update]
  
  def index
    @educations = Education.all
  end
  
  def new
    @education = Education.new
  end
  
  def create
    #raise params.inspect
    country_id = if params[:new_country].present?
                    @country = Country.new(:country_name => params[:new_country])
                    @country.save
                    @country.id
                  else
                    params[:ed_country]
                  end
    state_id = if params[:new_state].present?
                    @state = State.new(:state_name => params[:new_state], :country_id => country_id)
                    @state.save
                    @state.id
                  else
                    params[:ed_state]
                  end
    city_id = if params[:new_city].present?
                    @city = City.new(:city_name => params[:new_city], :state_id => state_id)
                    @city.save
                    @city.id
                  else
                    params[:ed_city]
                  end
    @qualification_id = if params[:qualification].present?
                          @qualification = Qualification.new(params[:qualification])
                          @qualification.save
                          @qualification.id
                        else
                          params[:qulification_id]
                        end
    @education = Education.new(params.require(:education).permit(:specilization, :institute, :year_of_admission, :year_of_pass, :cgpa_percentage).merge(:city_id => city_id))
    @education.save
    EducationQualification.create(:qualification_id => @qualification_id, :education_id => @education.id)
    redirect_to @education
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def update
    @education.update(params.require(:education).permit(:specilization, :institute, :year_of_admission, :year_of_pass, :cgpa_percentage).merge(:city_id => city_id))
  end
  
  def countries
    respond_to do |format|
      format.json  { render :json => getCountryList }
    end
  end
  
  def states
    respond_to do |format|
      format.json  { render :json => getStateList(params[:country_id]) }
    end
  end
  
  def cities
    respond_to do |format|
      format.json  { render :json => getCityList(params[:state_id]) }
    end
  end
  
  def qualifications
    respond_to do |format|
      format.json  { render :json => getQualificationList }
    end
  end
  
  private
 
  def find_education
    @education = Education.find(params[:id])
  end
  
end
