require 'byebug'

class RegistrationsController < ApplicationController
  def create
    debugger
    user = User.new(email: params[:email], password: params[:password])
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
