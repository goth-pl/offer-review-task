class Product::PolyMailerParameters < ProductParameters
  PRICE_WEIGHT = 0.1

  MIN_WIDTH = 1
  MAX_WIDTH = 200
  MIN_HEIGHT = 1
  MAX_HEIGHT = 200
  MATERIALS = %i(black transparent)

  attribute :width, :decimal
  attribute :height, :decimal
  enum :material, MATERIALS.zip(MATERIALS).to_h

  validates :width, presence: true, numericality: { greater_than_or_equal_to: MIN_WIDTH, less_than_or_equal_to: MAX_WIDTH }
  validates :height, presence: true, numericality: { greater_than_or_equal_to: MIN_HEIGHT, less_than_or_equal_to: MAX_HEIGHT }
  validates :material, presence: true

  def price
    (width + height) * (PRICE_WEIGHT + material_weight)
  end

  private

  def material_weight
    return 0.15 if transparent?

    0
  end
end