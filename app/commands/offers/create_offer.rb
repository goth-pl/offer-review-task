class CreateOffer
  include Wisper::Publisher

  def call(params)
    offer = Offer.new(params)
    offer.status = :created

    if offer.save
      broadcast(:create_offer_successful, offer)
    else
      broadcast(:create_offer_failed, offer.errors)
    end
  end
end