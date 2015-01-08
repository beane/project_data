module DateTimeHelper
  def difference_in_days(end_date, start_date)
    raise ArgumentError unless end_date.is_a?(DateTime) && start_date.is_a?(DateTime)
    return difference_in_days(start_date, end_date) if end_date < start_date

    seconds = end_date.to_i - start_date.to_i
    minutes = seconds / 60
    hours   = minutes / 60
    days    = hours   / 24
    days
  end
end
