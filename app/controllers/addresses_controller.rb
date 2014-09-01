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
  #raise params.inspect
   @address = Address.create(params_present_address)
		@address1 = Address.create(params.require(:address).permit(:line3, :line4, :city1, :state1, :country1, :zipcode1))
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
    params.require(:address).permit(:line, :line1, :city, :state, :country, :zipcode)
  end
  
 
  
end  
