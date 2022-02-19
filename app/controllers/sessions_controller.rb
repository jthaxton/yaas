class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user.empty?
      render json: { user: nil, session: session, errors: ["Username/password combination invalid."] }
      return
    end

    if user.valid_password?(params[:password])
      sign_in(user)
      render json: { user: user.serialized, session: session, errors: [] }
    else
      render json: { user: nil, session: session, errors: ["Username/password combination invalid."] }
    end
  end

  def show
    if current_user
      render json: { user: user.serialized, session: session, errors: [] }
    else
      render json: { user: user.serialized, session: session, errors: ["No current_user found."] }
    end
  end


  def destroy
    if current_user
      sign_out(current_user)
      render json: { user: nil, session: session, errors: [] }
    else
      render json: { user: nil, session: session, errors: ["No current_user found."] }
    end
  end
end
