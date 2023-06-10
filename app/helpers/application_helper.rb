module ApplicationHelper
  def this_year
    DateTime.current.year
  end

  def last_year
    DateTime.current.year - 1
  end

  def formatted_time_in(time, time_zone)
    time.in_time_zone(time_zone).strftime("%Y-%m-%d %H:%M %Z")
  end
end
