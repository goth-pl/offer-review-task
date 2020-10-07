class ApplicationController < ActionController::API
  before_action :authenticate_request

  protected

  def current_user
    @current_user || nil
  end

  def authenticate_request
    command = AuthenticateRequest.new

    command.on(:authenticate_request_successful) { |user| @current_user = user }
    command.on(:authenticate_request_failed) { |error| render json: { error: error }, status: :unauthorized }

    command.call(request.headers)
  end
end
