class Activity < ActiveRecord::Base
  has_many :resets

  validates :name, presence: true, uniqueness: true

  def last_reset
    Reset.where(activity_id: id).order(datetime: :desc).limit(1).first
  end
end
