# frozen_string_literal: true

module ApplicationHelper
  def formatted_time_creation(to_time)
    from_time = Time.current
    distance_of_time_in_words(from_time, to_time)
  end

  def nav_tab(text, path, options = {})
    css_class = if current_page?(options[:current])
                  "#{options[:class]} #{options[:active]}"
                else
                  "#{options[:class]} #{options[:passive]}"
                end

    link_to text, path, class: css_class
  end
end
