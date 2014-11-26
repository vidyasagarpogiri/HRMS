class Album < ActiveRecord::Base
  belongs_to :employee # Album belongs to an employee
  has_many :photos # One album can hav multiple photos
  accepts_nested_attributes_for :photos # Allows album to accept multiple photos
  validates :title, presence: true # Validation for album's title
  validates :description, presence: true # Validation for album's description
  validates :employee_id, presence: true # Validation for employee_id to whome album belongs
end
