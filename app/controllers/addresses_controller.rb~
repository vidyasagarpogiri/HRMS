class AddressesController < ApplicationController
  
    
  include AddressHelper
  
  def index
    @employee = Employee.find(params[:employee_id])
    if @employee.present_address_id.present? && @employee.permanent_address_id.present?
      @address1 = Address.find(@employee.present_address_id)
      @address2 = Address.find(@employee.permanent_address_id)
    else
      redirect_to new_employee_address_path(@id)
    end
    #raise @address2.inspect
    
  end
  
  def new
    @address = Address.new
    @employee = Employee.find(params[:employee_id])
  end
  
  def create
  
    country_id1 = if params[:country].present?
                    @country = Country.new(:country_name => params[:country])
                    @country.save
                    @country.id
                  end
      country_id2 = if params[:country2].present?
                    @country = Country.new(:country_name => params[:country2])
                    @country.save
                    @country.id
                  end
    state_id1 = if params[:state].present?
                    @state = State.new(:state_name => params[:state], :country_id => country_id1)
                    @state.save
                    @state.id
                  end
    state_id2 = if params[:state2].present?
                    @state = State.new(:state_name => params[:state2], :country_id => country_id2)
                    @state.save
                    @state.id
                  end
    city_id1 = if params[:city].present?
                    @city = City.new(:city_name => params[:city], :state_id => state_id1)
                    @city.save
                    @city.id
                  end
   city_id2 = if params[:city2].present?
                    @city = City.new(:city_name => params[:city2], :state_id => state_id2)
                    @city.save
                    @city.id
                  end
   @address1 = Address.new(params_present_address)
   @address1.save
   @address1.update(city_id: city_id1)  #upadting present address id in employee
   
   
   
   @address2 = Address.create(line: params[:line3], line1: params[:line4], city_id: city_id2)
   @employee = Employee.find(params[:employee_id])

   @employee.update(:present_address_id => @address1.id, :permanent_address_id => @address2.id) #updating perminent address id in employee
   
   redirect_to employee_addresses_path
    end

  
  def show
   #raise params.ispect
  end
  
  def edit
    #raise params.inspect
    @employee = Employee.find(params[:employee_id])
    @address = Address.find(params[:id])
    
  end
  
  def update
    @address = Address.find(params[:id])
    @address.update(params_present_address)
    redirect_to employee_addresses_path
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
