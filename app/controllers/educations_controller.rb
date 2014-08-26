class EducationsController < ApplicationController
  
  include AddressHelper
  
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
    @education = Education.create(params.require(:education).permit(:specilization, :institute, :year_of_admission, :year_of_pass, :cgpa_percentage).merge(:city_id => city_id))
    redirect_to @education
  end
  
  def show
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
  
end
