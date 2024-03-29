# frozen_string_literal: true

# free_item_rule.rb
class FreeItemRule
  def initialize(code)
    @code = code
  end

  def apply(items)
    selected_items = items.select { |i| i.code == @code }
    selected_items.each do |item|
      item.price = 0
    end
  end
end
