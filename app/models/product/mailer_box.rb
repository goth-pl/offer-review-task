class Product::MailerBox < Product
  MIN_QUANTITY = 200
  MAX_QUANTITY = 1000

  attribute :parameters, MailerBoxParameters.to_type

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: MIN_QUANTITY, less_than_or_equal_to: MAX_QUANTITY }
end