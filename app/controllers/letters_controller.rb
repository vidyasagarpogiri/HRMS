class LettersController < ApplicationController
  
  before_filter :hr_manager
  
  def index
    
  end
  
  def reference_letter
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReferenceLetter.new(current_user, @hr_manager)
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
          pdf = AddressProofLetter.new(current_user, @hr_manager, @address1, @address2 )
          send_data pdf.render, filename: 'AddressProofLetter.pdf', type: 'application/pdf'
        end
      end
  end
  
  def salary_certificate
   @salary = current_user.employee.salary
    respond_to do |format|
      format.html
      format.pdf do
        pdf = SalaryCertificate.new(current_user)
        send_data pdf.render, filename: 'SalaryCertificate.pdf', type: 'application/pdf'
      end
    end
  end
  
  def reference_notification # email for reference letter
    @user = current_user
    Notification.delay.reference_notification(@user, @hr_manager)
    redirect_to reference_letter_letters_path
  end
  
  def address_notification  # email for address proof
    @user = current_user
    @employee = @user.employee
    @address1 = @employee.addresses.where(:address_type=>0).first
		@address2 = @employee.addresses.where(:address_type=>1).first
    Notification.delay.address_notification(@user, @hr_manager, @address1, @address2)
    redirect_to address_proof_letter_letters_path
  end
  
   def salary_notification  # email for salary certificate
  #raise params.inspect
    @user = current_user
    pdf = SalaryCertificate.new(current_user, @hr_manager)
    Notification.salary_notification(@user).deliver
    #raise Notification.inspect
    redirect_to salary_certificate_letters_path
  end


  private
  def hr_manager
    hr_managers = Designation.find_by(designation_name: "HR Manager").employees
    if hr_managers.present? 
      @hr_manager = hr_managers.first.full_name
    else
      @hr_manager = "Manager"
    end
  end
end

