require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @product = Product.new
      @product.category = Category.create(name: "Balls")
      @product.name = "Basketball"
      @product.price_cents = 30
      @product.quantity = 10
    end
    it 'should validate a new product' do
      expect(@product).to be_valid
    end
    it 'should validate presence of name' do
      @product.name = nil
      @product.valid?
      
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it 'should validate presence of price' do
      @product.price_cents = nil
      @product.valid?

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it 'should validate presence of quantity' do
      @product.quantity = nil
      @product.valid?

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'should validate presence of category' do
      @product.category = nil
      @product.valid?

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end