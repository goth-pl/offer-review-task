class Product::MailerBoxParameters < ProductParameters
  PRICE_WEIGHT = 0.1

  MIN_WIDTH = 1
  MAX_WIDTH = 200
  MIN_HEIGHT = 1
  MAX_HEIGHT = 200
  MIN_LENGTH = 1
  MAX_LENGTH = 200

  attribute :width, :integer
  attribute :height, :integer
  attribute :length, :integer

  validates :width, presence: true, numericality: { greater_than_or_equal_to: MIN_WIDTH, less_than_or_equal_to: MAX_WIDTH }
  validates :height, presence: true, numericality: { greater_than_or_equal_to: MIN_HEIGHT, less_than_or_equal_to: MAX_HEIGHT }
  validates :length, presence: true, numericality: { greater_than_or_equal_to: MIN_LENGTH, less_than_or_equal_to: MAX_LENGTH }

  def price
    (width + height + length) * PRICE_WEIGHT
  end
end