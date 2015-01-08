class Activity < ActiveRecord::Base
  require 'datetime_helper' # it's hiding in lib/
  include DateTimeHelper # defines `difference_in_days`

  has_many :resets

  validates :name, presence: true, uniqueness: true

  # returns: <Reset object>
  def first_reset
    Reset.where(activity_id: id).order(datetime: :asc).limit(1).first
  end

  # returns: <Reset object>
  def last_reset
    Reset.where(activity_id: id).order(datetime: :desc).limit(1).first
  end

  # returns: [DateTime, DateTime]
  def current_streak_range
    last_date = last_reset.datetime.to_datetime
    [last_date, DateTime.now]
  end

  # returns: Integer
  # number of days since last reset
  def current_streak_length
    start_date, end_date = current_streak_range
    difference_in_days(end_date, start_date)
  end

  # returns: [DateTime, DateTime]
  def longest_streak_range
    if longest_streak_length > current_streak_length
      return self._longest_streak_range
    end
    current_streak_range
  end

  # returns: Integer
  def longest_streak_length
    start_date, end_date = self._longest_streak_range
    days = difference_in_days(end_date, start_date)
    # the current streak might be longer than the longest
    # historical streak, but our query doesn't account for that
    longest_streak = days
    if current_streak_length > longest_streak
      longest_streak = current_streak_length
    end
    longest_streak
  end

  protected

  # returns: [DateTime, Datetime]
  # does not include the current streak, which may be longer
  def _longest_streak_range
    query = <<-SQL
      SELECT r.datetime as datetime, r.next_datetime as next_datetime
      FROM (

        # selects 2 columns:
        #   - a datetime from the resets table
        #   - the next consecutive datetime found in the table

        SELECT r1.datetime, (

          # selects the next consecutive datetime

          SELECT r2.datetime
          FROM resets r2
          WHERE r2.datetime > r1.datetime
          ORDER BY datetime ASC
          LIMIT 1
        ) next_datetime

        FROM resets r1
      ) r

      WHERE r.datetime IS NOT NULL
      AND r.next_datetime IS NOT NULL
      ORDER BY TIMESTAMPDIFF(SECOND, next_datetime, datetime) ASC
      LIMIT 1
    SQL

    results = Reset.find_by_sql(query).first
    [results.datetime.to_datetime, results.next_datetime.to_datetime]
  end
end
