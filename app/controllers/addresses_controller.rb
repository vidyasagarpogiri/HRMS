class AddressesController < ApplicationController
  
    
  include AddressHelper
  
  def new
    @address = Address.new
    @employee = Employee.find(params[:employee_id])
  end
  
  def create
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
   @address1 = Address.new(params_present_address)
   @address1.save
   @address1.update(city_id: params[:ed_city])
   @address2 = Address.create(line: params[:line3], line1: params[:line4], city_id: params[:ed_city_parmanent])
   @employee = Employee.find(params[:employee_id])
   @employee.update(:present_address_id => @address1.id, :permanent_address_id => @address2.id)
   redirect_to address_path(@address2)
  end
  
  def show
    @address1 = Address.find(params[:id])
    @address2 = Address.find(params[:id])
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
  
  
  
  private
  
  def params_present_address
    params.require(:address).permit(:line, :line1)
  end
  
 
  
end  
