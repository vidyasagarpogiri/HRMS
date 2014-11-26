class TaxExemption < ActiveRecord::Base
  validates :exemption_limit, presence: true
end
