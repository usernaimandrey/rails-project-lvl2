# frozen_string_literal: true

categoryes = %w[JS Php Ruby Linux]

categoryes.each do |category|
  Category.create(
    name: category
  )
end
