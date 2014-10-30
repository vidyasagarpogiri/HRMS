class CompanyPayRollMaster < ActiveRecord::Base
  # static statuses for payroll
  Generated = "PayRollGenerated"
  Processing = "PayRollProcessing"
  SendToBank = "SendToBank"
end
