defmodule EventWeb.Helpers.Auth do
  def create_token(user_id) do
    signer = Joken.Signer.create("HS256",Application.get_env(:event,:auth_secret))
    extra_claims = %{"user_id" => user_id}
    Event.Token.generate_and_sign!(extra_claims, signer)
  end

  def is_authenticated(password, db_password) do
    Pbkdf2.verify_pass(password, db_password)
  end
end
