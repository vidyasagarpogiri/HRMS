class AddressesController < ApplicationController


  before_filter :hr_view,  only: ["new", "edit"]
  before_filter :other_emp_view
  before_action :find_employee, only: [:index, :new, :edit, :update, :destroy]
  before_action :find_address, only: [:edit, :update, :destroy]
  
  def index
		@address1 = @employee.addresses.where(:address_type=>0).first
		@address2 = @employee.addresses.where(:address_type=>1).first
  end
  
  def new
    @employee = Employee.find(params[:employee_id])
    @address = Address.new
   	@address_type_value, @address_type = false, "Present" if params[:address_type]=="false" 
 		@address_type_value, @address_type = true, "Permanent" if params[:address_type]=="true"
 		@copy_address_type = @address_type == "Present" ? "Permanent":"Present" if @address_type.present?
  end
  
  def create
   	@address_type_value, @address_type = false, "Present" if params[:address_type]=="false" 
 		@address_type_value, @address_type = true, "Permanent" if params[:address_type]=="true"
		@employee = Employee.find(params[:employee_id])
   	@address = @employee.addresses.create(params_present_address)
		@errors = @address.errors.full_messages	
		@address1 = @employee.addresses.where(:address_type=>0).first
		@address2 = @employee.addresses.where(:address_type=>1).first

 	end
 
  def show
  end
  
  def edit  
  end
  
  def update
    @address.update(params_present_address)
    @errors = @address.errors
    @address1 = @employee.addresses.where(:address_type=>0).first
		@address2 = @employee.addresses.where(:address_type=>1).first
  end
    
	def destroy
    if @employee.present_address_id == @address.id
			@employee.update(:present_address_id => nil)
			@address.destroy
		else
			@address.destroy
			@employee.update(:permanent_address_id => nil)
		end	
		redirect_to employee_addresses_path	
	end
   
  private
  
  def params_present_address
    params.require(:address).permit(:line, :line1, :city, :state, :country, :zipcode, :address_type)
  end
  
  def find_employee
    @employee = Employee.find(params[:employee_id])
  end
  
  def find_address
    @address = Address.find(params[:id])
  end 
  
end  
