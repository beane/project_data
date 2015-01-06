class Reset < ActiveRecord::Base
  belongs_to :activity

  validates :activity_id, :datetime, presence: true

  # eg. Sunday, Monday...
  def day_name
    datetime.strftime("%A")
  end

  # eg. January, February...
  def month_name
    datetime.strftime("%B")
  end

  def datetime_display
    datetime.strftime("%A, %e %B, %Y - %H:%M")
  end
end
