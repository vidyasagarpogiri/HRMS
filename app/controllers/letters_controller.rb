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
    pdf = ReferenceLetter.new(current_user)
    #@attachemnts = pdf
    #pdf = ReferenceLetter.new(current_user)
    #raise pdf.inspect
      #pdf = ReferenceLetter.new(current_user)   
      #raise pdf.inspect
      #attachment.inline['ReferenceLetter.pdf'] = { :content => pdf.render, :mime_type => 'application/pdf'}
     #mail to: "#{@user.email}",
         #subject: "reference letter"
   Notification.delay.reference_notification(@user)
   redirect_to reference_letter_letters_path
  #attachments.inline["payslip.pdf"] = File.read(file_path)
  #  mail(:to => @user.email, :subject => "payslip of #{I18n.t("date.abbr_month_names")[Date.today.month-1]} of Mr. #{@employee.full_name}  ")
  end
  
  def address_notification  # email for address proof
  #raise params.inspect
    @user = current_user
    pdf = AddressProofLetter.new(current_user)
    Notification.delay.address_notification(@user)
    redirect_to address_proof_letter_letters_path
  end
  
   def salary_notification  # email for salary certificate
  #raise params.inspect
    @user = current_user
    pdf = SalaryCertificate.new(current_user)
    Notification.salary_notification(@user).deliver
    #raise Notification.inspect
    redirect_to salary_certificate_letters_path
  end

end

