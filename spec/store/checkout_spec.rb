# frozen_string_literal: true

require './store/checkout'
require './store/discount_rule'
require './store/two_for_one_rule'
require './store/free_item_rule'

RSpec.describe :checkout do
  let(:rule_one) { TwoForOneRule.new('VOUCHER') }
  let(:rule_two) { DiscountRule.new('TSHIRT', 3, 1.0) }
  let(:rule_three) { FreeItemRule.new('MUG') }
  let(:products) do
    [
      Product.new(code: 'VOUCHER', name: 'Voucher', price: 5.0),
      Product.new(code: 'TSHIRT', name: 'T-Shirt', price: 20.0),
      Product.new(code: 'MUG', name: 'Mug', price: 7.50)
    ]
  end
  let(:checkout) { Checkout.new([rule_one, rule_two], products) }

  describe 'scan' do
    it 'should add valid successfully' do
      expect(checkout.scan('VOUCHER')).to eql(true)
    end

    it 'should not add invalid successfully' do
      expect(checkout.scan('VCHER')).to eql(false)
    end
  end

  describe 'show' do
    it 'should show total values with items' do
      checkout.scan('MUG')
      checkout.scan('MUG')
      expect(checkout.show).to eql(['Items: MUG, MUG', 'Total: 15.0$'])
    end

    it 'should return No items to checkout' do
      expect(checkout.show).to eql('No items to checkout')
    end
  end
end
