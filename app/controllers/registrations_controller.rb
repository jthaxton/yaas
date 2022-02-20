
class RegistrationsController < ApplicationController
  def create
    user = User.new(
      email: params[:email],
      password: params[:password],
      allowed_origin_id: origin.id
    )
    if user.valid?
      user.save!
      sign_in(user)
      jwt = user.generate_jwt
      render json: { jwt: jwt.to_json, errors: [] }
    else
      render json: { jwt: nil, errors: user.errors }
    end
  end
end
