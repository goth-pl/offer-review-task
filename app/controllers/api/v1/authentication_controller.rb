class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    command = AuthenticateUser.new

    command.on(:authenticate_user_successful) { |jwt| render json: { token: jwt } }
    command.on(:authenticate_user_failed) { |error| render json: { error: error }, status: :unauthorized }

    command.call(params[:email], params[:password])
  end
end