class Api::V1::OffersController < ApplicationController
  before_action :set_offer, only: [:show, :accept, :reject]

  def index
    offers = policy_scope(Offer.includes(:products, :salesman, :client))

    render json: { offers: prepare_offers_to_render(offers) }
  end

  def show
    authorize @offer

    render json: { offer: prepare_offers_to_render(@offer) }
  end

  def create
    authorize :offer

    command = CreateOffer.new

    command.on(:create_offer_successful) { |offer| render json: { offer: prepare_offers_to_render(offer) }, status: :created }
    command.on(:create_offer_failed) { |errors| render json: { errors: errors }, status: :bad_request }

    command.call(offer_params)
  end

  def accept
    authorize @offer

    command = AcceptOffer.new

    command.on(:accept_offer_successful) { |offer| render json: { offer: prepare_offers_to_render(offer) } }
    command.on(:accept_offer_failed) { |errors| render json: { errors: errors }, status: :bad_request }

    command.call(@offer)
  end

  def reject
    authorize @offer

    command = RejectOffer.new

    command.on(:reject_offer_successful) { |offer| render json: { offer: prepare_offers_to_render(offer) } }
    command.on(:reject_offer_failed) { |errors| render json: { errors: errors }, status: :bad_request }

    command.call(@offer)
  end

  private

  def prepare_offers_to_render(offers)
    offers.as_json(
      include: [
        { products: { except: [:id, :created_at, :updated_at, :offer_id] } },
        { salesman: { only: [:email] } },
        { client: { only: [:email] } }
      ],
      except: [:salesman_id, :client_id, :updated_at]
    )
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.permit(
      :client_id,
      products_attributes: [
        :type, :quantity, parameters: {}
      ]
    ).merge(
      salesman_id: current_user.id
    )
  end
end