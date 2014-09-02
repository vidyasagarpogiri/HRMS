class AddressesController < ApplicationController
  
   layout "profile_template", only: [:index, :new, :create, :show, :edit, :update]
 # include AddressHelper

  
  def index
    @employee = Employee.find(params[:employee_id])
    if @employee.present_address_id.present? || @employee.permanent_address_id.present?
			if @employee.present_address_id.present?

	      @address1 = Address.find(@employee.present_address_id)  
			end
			if @employee.permanent_address_id.present?
      	@address2 = Address.find(@employee.permanent_address_id)
			end #if @employee.permanent_address_id.present?
    else
      redirect_to new_employee_address_path(@id)
      #@address = Address.new
    end
    
  end
  
  def new
    @address = Address.new
    @employee = Employee.find(params[:employee_id])
  end
  
  def create
		@employee = Employee.find(params[:employee_id])
  #raise params.inspect
   @address = Address.create(params_present_address)
 #raise @address.inspect
		@address1 = Address.create(:line => params[:line3], :line1 => params[:line4], :city => params[:city1], :state => params[:state1], :country => params[:country1], :zipcode => params[:zipcode1])
#raise @address1.inspect
	@employee.update(:permanent_address_id => @address1.id, :present_address_id => @address.id )
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
  
  
	def destroy
			
		@employee = Employee.find(params[:employee_id])
		@address = Address.find(params[:id])
    if @employee.present_address_id == @address.id
			@employee.update(:present_address_id => nil)
			@address.destroy
		#raise params.inspect
		else
			@address.destroy
			@employee.update(:permanent_address_id => nil)
		end
		
		redirect_to employee_addresses_path
	
	end
  
  
  
  private
  
  def params_present_address
    params.require(:address).permit(:line, :line1, :city, :state, :country, :zipcode)
  end
  
 
  
end  
