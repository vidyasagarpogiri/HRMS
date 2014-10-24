class Event < ActiveRecord::Base
 

  has_many :holiday_calenders
  has_many :departments, :through => :holiday_calenders


  validates :event_name, uniqueness: { case_sensitive: false }
  validates :event_date, uniqueness: true
  
   def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |event|
        csv << event.attributes.values_at(*column_names)
      end
    end
  end
  
end
