# frozen_string_literal: true

module ApplicationHelper
  def formatted_time_creation(to_time)
    from_time = Time.current
    distance_of_time_in_words(from_time, to_time)
  end
end
