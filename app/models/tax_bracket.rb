class TaxBracket < ActiveRecord::Base
  validates :lower_limit, presence: true
  validates :upper_limit, presence: true
  validates :tax_percentage, presence: true
  validates :min_tax, presence: true 
  validate :lower_limit_less_than_upper_limit # this is custom validation
  
  def lower_limit_less_than_upper_limit
    if (lower_limit.present? && upper_limit.present?) && lower_limit >= upper_limit
      errors.add(:lower_limit, "Lower limit can't be greater than or equl upper value")
    end
  end
  
end
