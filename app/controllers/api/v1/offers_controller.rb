class Api::V1::OffersController < ApplicationController
  before_action :set_offer, only: [:show, :accept, :reject]

  def index
    render json: { offers: Offer.all }
  end

  def show
    render json: { offer: @offer }
  end

  def create
    command = CreateOffer.new

    command.on(:create_offer_successful) { |offer| render json: { offer: offer }, status: :created }
    command.on(:create_offer_failed) { |errors| render json: { errors: errors }, status: :bad_request }

    command.call(offer_params)
  end

  def accept
    command = AcceptOffer.new

    command.on(:accept_offer_successful) { |offer| render json: { offer: offer } }
    command.on(:accept_offer_failed) { |errors| render json: { errors: errors }, status: :bad_request }

    command.call(@offer)
  end

  def reject
    command = RejectOffer.new

    command.on(:reject_offer_successful) { |offer| render json: { offer: offer } }
    command.on(:reject_offer_failed) { |errors| render json: { errors: errors }, status: :bad_request }

    command.call(@offer)
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.permit(
      :client_id, :salesman_id,
      products_attributes: [
        :type, :quantity, parameters: {}
      ]
    )
  end
end