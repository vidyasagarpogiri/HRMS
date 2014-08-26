class AddressesController < ApplicationController
  def new
    @address = Address.new
    
  end
  
  def create
    #raise params.inspect
   @address1 = Address.create(params_permanent_address)
   @address2 = Address.create(line: params[:line3], line1: params[:line4])
   redirect_to address_path(@address1)
   
  end
  
  def show
  @address1 = Address.find(params[:id])
  @address2 = Address.find(params[:id])
  
  end
  
  private
  
  def params_permanent_address
    params.require(:address).permit(:line, :line1)
  end
  

end
