# frozen_string_literal: true

require 'terminal-table'

# product.rb
class Product
  attr_reader :code, :name, :price

  def initialize(code:, name:, price:)
    @code = code
    @name = name
    @price = price
  end

  def to_s
    Terminal::Table.new(headings: %w[Code Name Price], rows: [to_a])
  end

  def to_a
    [@code, @name, @price]
  end
end
