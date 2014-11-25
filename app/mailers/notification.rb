# This class is for sending email
class Notification < ActionMailer::Base
  require 'open-uri'
  default from: 'from@example.com'

  def applyleave(employee, leave_history)
    @employee = employee
    @leave_history = leave_history
    mail(to: @employee.reporting_manager_user, subject: 'Leave Applied By' " #{@employee.first_name} #{@employee.last_name}")
  end

  def accept_leave(employee, leave_history)
    @employee = employee
    @leave_history = leave_history
    mail(to: @employee.user.email, subject: 'Leave Approved')
  end

  def reject_leave(employee, leave_history)
    @employee = employee
    @leave_history = leave_history
    mail(to: @leave_history.employee.user.email, subject: 'Leave Rejected')
  end

  def job_notification(user, recruitment)
    @recruitment = recruitment
    mail(to: user.email, subject: 'Bring Your Buddy - Employee Referral - New Job Opening for' " #{@recruitment.title}.")
  end

  def announcement_notification(user, announcement)
    @announcement = announcement
    mail(to: user.email, subject: 'Announcement for' " #{@announcement.title}")
  end

  def event_notification(user, amzurevent)
    @amzurevent = amzurevent
    mail(to: user.email, subject: 'Amzur Technologies is conducting a'  " #{@amzurevent.title} Event ")
  end

  def policy_notification(user, policy)
    @policy = policy
    mail(to: user.email, subject: "#{@policy.title}" 'Policy')
  end

  def holiday_list(user, events, group)
    @events = events
    @group = group
    mail(to: user.email, subject: 'Holidays List - ' "#{@events.first.event_date.to_date.year}")
  end

  def send_payslip(mail, month_name, year)
    attachments.inline['payroll.xlsx'] = File.read("#{Rails.root}/public/Payroll/#{month_name}-#{year}-payslips.xlsx")
    mail(to: mail, subject: 'Payroll for'  "#{month_name}-#{year}")
  end

  # birth day alert code
  def birthday_notification(user, employee)
    @user = user
    @employee = employee
    attachments.inline['birthday.jpg'] = File.read("#{Rails.root}/public/assets/birthdaycards/#{rand(6)}.jpg")
    mail(to: @user.email, subject: 'Happy Birthday To ' " #{@employee.full_name}")
  end

  def send_pdf(payslip, file_path)
    @employee = payslip.employee
    @user = @employee.user
    attachments.inline['payslip.pdf'] = File.read(file_path)
    mail(to: @user.email, subject: 'payslip of #{I18n.t("date.abbr_month_names")[Date.today.month-1]} of Mr. #{@employee.full_name}')
  end

  # email for reference letter
  def reference_notification(current_user, hr_manager)
    @user = current_user
    @hr_manager = hr_manager
    referenceletter = ReferenceLetter.new(@user, hr_manager)
    attachments['ReferenceLetter.pdf'] = { mime_type: 'application/pdf', content: referenceletter.render }
    mail(to: @user.email, subject: 'Amzur Technologies - Reference Letter')
  end

  # email for address proof
  def address_notification(user, hr_manager, present_address, perm_address)
    @user = user
    addressproofletter = AddressProofLetter.new(@user, hr_manager, present_address, perm_address)
    attachments['AddressProofLetter.pdf'] = { mime_type: 'application/pdf', content: addressproofletter.render }
    mail(to: @user.email, subject: 'Amzur Technologies - Address Proof')
  end

  # email for salary certificate
  def salary_notification(current_user)
    @user = current_user
    salarycertificate = SalaryCertificate.new(@user)
    attachments['SalaryCertificate.pdf'] = { mime_type: 'application/pdf', content: salarycertificate.render }
    mail(to: @user.email, subject: 'Amzur Technologies - Salary Certificate')
  end
  
  #def status_notification(@emp, @status)
 #@user = user
  #@emp = employee
  #raise @employee.inspect
  #raise @user.inspect
  # mail(to: @employee.user.email, subject: 'Status')
 #raise status.inspect
 # end
end
