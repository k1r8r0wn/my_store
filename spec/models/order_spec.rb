require 'rails_helper'

describe Order, type: :model do
  it 'calculates the total price of the order' do
    item1 = Item.new(price: 10)
    item2 = Item.new(price: 10)

    order = Order.new
    order.items << item1
    order.items << item2

    order.calculate_total
    expect(order.total).to eq(20)
  end
end
