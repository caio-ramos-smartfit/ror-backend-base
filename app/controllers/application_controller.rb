class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  attr_reader :current_user

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
  end

  def authenticate_user!
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    
    begin
      decoded = JWT.decode(token, Rails.application.credentials.secret_key_base || 'development_jwt_secret', true, { algorithm: 'HS256' })
      @current_user = User.find(decoded[0]['sub'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
