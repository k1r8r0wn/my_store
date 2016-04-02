require 'rails_helper'

describe Item, type: :model do
  it "validates the name & makes sure it's not empty" do
    item = Item.new(name: '')
    item.valid?
    expect(item.errors[:name]).not_to be_empty
  end
end
