class LettersController < ApplicationController
  
  def index
    
  end
  
  def reference_letter
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReferenceLetter.new(current_user)
        send_data pdf.render, filename: 'ReferenceLetter.pdf', type: 'application/pdf'
      end
    end
  end
  
  def address_proof_letter
    @employee = current_user.employee
    @address1 = @employee.addresses.where(:address_type=>0).first
		@address2 = @employee.addresses.where(:address_type=>1).first
    respond_to do |format|
        format.html
        format.pdf do
          pdf = AddressProofLetter.new(current_user)
          send_data pdf.render, filename: 'AddressProofLetter.pdf', type: 'application/pdf'
        end
      end
  end
  
  def salary_certificate
    respond_to do |format|
      format.html
      format.pdf do
        pdf = SalaryCertificate.new(current_user)
        send_data pdf.render, filename: 'SalaryCertificate.pdf', type: 'application/pdf'
      end
    end
  end
  
end
