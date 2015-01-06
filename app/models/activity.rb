class Activity < ActiveRecord::Base
  has_many :resets

  validates :name, presence: true, uniqueness: true
end
