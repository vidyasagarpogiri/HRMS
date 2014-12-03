# Exemptions Controller for Tax Exemptions
class TaxExemptionsController < ApplicationController
  
  def index
    @tax_exemptions = TaxExemption.all
  end
  
  def new
    @tax_exemption = TaxExemption.new
  end
  
  def create
    @tax_exemption = TaxExemption.new(params_tax_exemption)
    if @tax_exemption.save
      redirect_to tax_exemptions_path 
    else
      render "new"
    end
  end
  
  def edit
    @tax_exemption = TaxExemption.find(params[:id])
  end
  
  def update
    @tax_exemption = TaxExemption.find(params[:id])
    if @tax_exemption.update(params_tax_exemption)
      redirect_to tax_exemptions_path 
    else
      render "edit"
    end
  end
  
  private
  
  def params_tax_exemption
    params.require(:tax_exemption).permit(:gender, :exemption_limit) 
  end
end
