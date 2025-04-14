class Api::V1::AuthController < ApplicationController
  before_action :authenticate_user!, only: [:me, :sign_out]

  # POST /api/v1/auth/sign_up
  def sign_up
    user = User.new(sign_up_params)
    
    if user.save
      token = generate_jwt_token(user)
      render json: { token: token, user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /api/v1/auth/sign_in
  def sign_in
    user = User.find_by(email: sign_in_params[:email])
    
    if user && user.valid_password?(sign_in_params[:password])
      token = generate_jwt_token(user)
      render json: { token: token, user: user }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  # DELETE /api/v1/auth/sign_out
  def sign_out
    # JWT tokens are stateless, so we don't need to do anything server-side
    # The client should discard the token
    render json: { message: 'Signed out successfully' }, status: :ok
  end

  # GET /api/v1/auth/me
  def me
    render json: { 
      id: current_user.id, 
      email: current_user.email, 
      created_at: current_user.created_at 
    }, status: :ok
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end

  def generate_jwt_token(user)
    JWT.encode(
      { sub: user.id, exp: 24.hours.from_now.to_i },
      Rails.application.credentials.secret_key_base || 'development_jwt_secret',
      'HS256'
    )
  end
end
