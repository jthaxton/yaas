require 'byebug'

class RegistrationsController < ApplicationController
  def create
    user = User.new(email: params[:email], password: params[:password])
    if user.valid? 
      user.save!
      sign_in(user)
      render json: { user: user.serialized, session: session, errors: [] }
    else
      render json: { user: nil, session: session, errors: user.errors }
    end
  end
end
