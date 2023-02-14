# frozen_string_literal: true

require_relative 'store'
require_relative 'item'

# checkout.rb
class Checkout
  attr_reader :store, :items

  def initialize(pricing_rules, products)
    @rules = pricing_rules
    @store = Store.new(products)
    @items = []
    @valid_codes = @store.valid_codes
  end

  def scan(code)
    if @valid_codes.include?(code)
      product = @store.find(code)
      item = Item.new(product.code, product.price)
      @items.push(item)
      true
    else
      false
    end
  end

  def show
    items = @items.map(&:code).join(', ')
    if items.size.positive?
      ["Items: #{items}", "Total: #{total}$"]
    else
      'No items to checkout'
    end
  end

  def total
    @rules.each { |rule| rule.apply(@items) }
    @items.inject(0.0) { |total, item| total += item.price }
  end
end
