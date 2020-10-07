class AuthenticateUser
  include Wisper::Publisher

  def call(email, password)
    user = User.find_by(email: email)

    if user&.authenticate(password)
      broadcast(:authenticate_user_successful, JsonWebToken.encode(id: user.id))
    else
      broadcast(:authenticate_user_failed, :invalid_credentials)
    end
  end
end