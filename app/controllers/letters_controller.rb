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
