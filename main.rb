# frozen_string_literal: true

require 'json'
require './store/checkout'
require './store/discount_rule'
require './store/two_for_one_rule'
require './store/free_item_rule'
require 'pry'

class Main
  def initialize
    @rule_one = TwoForOneRule.new('VOUCHER')
    @rule_two = DiscountRule.new('TSHIRT', 3, 1.0)
    @rule_three = FreeItemRule.new('MUG')
    products = seed_products
    @checkout = Checkout.new([@rule_one, @rule_two], products)
    # @checkout = Checkout.new([@rule_one, @rule_two, @rule_three])
    @store = @checkout.store
  end

  def seed_products
    file = File.read('store/products.json')
    JSON.parse(file).map { |pro| Product.new(code: pro['code'], name: pro['name'], price: pro['price']) }
  end

  def prompt
    print '> '
  end

  def breakline
    puts "\n"
  end

  def all_products
    puts @store.list
  end

  def add_product
    puts 'Please enter code:'
    prompt
    code = gets.chomp

    breakline
    puts @checkout.scan(code) ? 'The product was added successfully' : 'This product does not exist'
  end

  def total_cart_price
    puts @checkout.show
  end

  def exit_cli
    puts 'Thankyou for shopping'
  end

  def run_cli
    option = 0
    while option != 4
      puts '
        Welcome to Store

        1. Inventory
        2. Scan product
        3. Total
        4. Exit
      '
      prompt

      option = gets.chomp.to_i
      breakline

      case option
      when 1
        all_products
      when 2
        add_product
      when 3
        total_cart_price
      when 4
        exit_cli
      else
        puts 'Please select a correct option'
      end
    end
  end
end

obj = Main.new
obj.run_cli
