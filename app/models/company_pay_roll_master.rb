class CompanyPayRollMaster < ActiveRecord::Base
  # static statuses for payroll
  GENERATED = "PayRoll Generated"
  PROCESSING = "PayRoll Processing"
  SENDTOBANK = "Send To Bank"
end
