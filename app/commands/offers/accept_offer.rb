class AcceptOffer
  include Wisper::Publisher

  def call(offer)
    if offer.update(status: :accepted)
      broadcast(:accept_offer_successful, offer)
    else
      broadcast(:accept_offer_failed, offer.errors)
    end
  end
end