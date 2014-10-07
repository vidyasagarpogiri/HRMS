class EmergencyContact < ActiveRecord::Base
  belongs_to :employee
  
  validates :name, presence: true, format: { with: /\A[a-zA-Z\s ]+\z/, message: "Please Enter only Alphabets" }
  validates :relation, presence: true, format: { with: /\A[a-zA-Z\s ]+\z/, message: "Please Enter only Alphabets" }
  validates :mobile1, presence: true, numericality: true , length: { maximum: 10, minimum:10 }
  validates :mobile2, numericality: true , length: { maximum: 10, minimum:10 }
end
