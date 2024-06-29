class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, JWT::DecodeError, with: :handle_unauthorized

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    @current_recruiter = find_current_recruiter
  end

  private

  def find_current_recruiter
    decoded = jwt_decode(token_from_request)
    Recruiter.find(decoded[:recruiter_id])
  end

  def token_from_request
    header = request.headers['Authorization']
    header.split(' ').last if header
  end

  def jwt_encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def jwt_decode(token)
    decoded = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    HashWithIndifferentAccess.new(decoded)
  end

  def handle_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
