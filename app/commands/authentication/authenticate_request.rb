class AuthenticateRequest
  include Wisper::Publisher

  def call(headers)
    decoded_token = decode_token(headers)

    return unless decoded_token.present?

    user = User.find_by(id: decoded_token[:id])

    if user.present?
      broadcast(:authenticate_request_successful, user)
    else
      broadcast(:authenticate_request_failed, :invalid_token)
    end
  end

  private

  def decode_token(headers)
    if !headers['Authorization'].present?
      broadcast(:authenticate_request_failed, :missing_token)

      return nil
    end

    token = headers['Authorization'].split(' ').last
    decoded_token = JsonWebToken.decode(token)

    if !decoded_token.present?
      broadcast(:authenticate_request_failed, :invalid_token)

      return nil
    end

    decoded_token
  end
end