# frozen_string_literal: true

require 'terminal-table'
require_relative 'product'
require 'pry'

# store.rb
class Store
  def initialize(args)
    @inventory = args.map { |product| [product.code.to_sym, product] }.to_h
  end

  def find(code)
    @inventory[code.to_sym]
  end

  def add_product(code, name, price)
    product = Product.new(code, name, price)
    @inventory[code.to_sym] = product
  end

  def list
    Terminal::Table.new(
      title: 'Store', headings: %w[Code Name Price],
      rows: @inventory.values.map(&:to_a)
    )
  end

  def products_quantity
    @inventory.size
  end

  def products
    @inventory.values
  end

  def valid_codes
    @inventory.values.map(&:code)
  end
end
