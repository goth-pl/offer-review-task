class Product::PolyMailer < Product
  MIN_QUANTITY = 50
  MAX_QUANTITY = 2000

  attribute :parameters, PolyMailerParameters.to_type

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: MIN_QUANTITY, less_than_or_equal_to: MAX_QUANTITY }
end