class RejectOffer
  include Wisper::Publisher

  def call(offer)
    if offer.update(status: :rejected)
      broadcast(:reject_offer_successful, offer)
    else
      broadcast(:reject_offer_failed, offer.errors)
    end
  end
end