# Author :Priyanka
# model for album where we can specify validations and relations.
class Album < ActiveRecord::Base
  has_many :likes, as: :likeable, dependent: :destroy #One Album can hav many likes  
  has_many :comments, as: :commentable, dependent: :destroy # Album  have more than one comment
  belongs_to :employee # Album belongs to an employee
  has_many :photos # One album can hav multiple photos
  accepts_nested_attributes_for :photos # Allows album to accept multiple photos
  validates :title, presence: true # Validation for album's title  
  validates :employee_id, presence: true # Validation for employee_id to whome album belongs
  # Displays the albums in descending order based on last updated time
  default_scope { order('updated_at DESC') }
end
