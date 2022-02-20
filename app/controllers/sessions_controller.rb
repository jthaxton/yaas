class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email], allowed_origin_id: request.headers["Origin"])
    if user.empty?
      render json: { jwt: nil, errors: ["Username/password combination invalid."] }
      return
    end

    if user.valid_password?(params[:password])
      sign_in(user)
      jwt = user.generate_jwt
      render json: { jwt: jwt.to_json, errors: [] }
    else
      render json: { jwt: nil, errors: ["Username/password combination invalid."] }
    end
  end

  def show
    if jwt_current_user
      render json: { jwt: jwt_current_user.generate_jwt.to_json, errors: [] }
    else
      render json: { jwt: nil, errors: ["No current_user found."] }
    end
  end

  def destroy
    if current_user
      sign_out(current_user)
      render json: { jwt: nil, errors: [] }
    else
      render json: { jwt: nil, errors: ["No current_user found."] }
    end
  end
end
