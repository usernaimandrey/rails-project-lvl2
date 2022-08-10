# frozen_string_literal: true

module ApplicationHelper
  def formattaed_time_creation(created_at)
    from_time = Time.current
    years = (from_time.year - created_at.year).years
    months = (from_time.month - created_at.month).months
    days = (from_time.day - created_at.day).days
    hours = (from_time.hour - created_at.hour).hours
    minutes = (from_time.min - created_at.min).minutes
    to_time = from_time + years + months + days + hours + minutes
    distance_of_time_in_words(from_time, to_time)
  end
end
