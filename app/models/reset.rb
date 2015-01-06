class Reset < ActiveRecord::Base
  belongs_to :activity

  validates :activity_id, :datetime, presence: true
end
