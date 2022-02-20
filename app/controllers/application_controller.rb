class ApplicationController < ActionController::API
  respond_to :json
  before_action :process_token
  before_action :origin

  def origin
    origin = AllowedOrigin.find_by(id: request.headers["Origin"])
    head :unauthorized if  origin.nil?
    origin
  end

  def process_token
    if request.headers['Authorization'].present?
      begin
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1].remove('"'), Rails.application.secrets.secret_key_base).first
        @jwt_current_user_id = jwt_payload['id']
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        head :unauthorized
      end
    end
  end

  def jwt_current_user
    @jwt_current_user ||= super || User.find(@jwt_current_user_id)
  end
end
