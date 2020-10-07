class Product < ApplicationRecord
  attribute :parameters, ProductParameters.to_type

  validates :type, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :parameters, store_model: true

  before_save :set_price

  protected

  def calculate_price
    parameters.price * quantity
  end

  def set_price
    self.price = calculate_price
  end
end
