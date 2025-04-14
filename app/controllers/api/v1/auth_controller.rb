class Api::V1::AuthController < ApplicationController
  before_action :authenticate_user!, except: [:sign_up, :login]

  # POST /api/v1/auth/sign_up
  def sign_up
    user = User.new(user_params)
    if user.save
      render json: { message: 'User registered successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /api/v1/auth/sign_in
  def login
    user = User.find_by(email: params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      token = JWT.encode(
        { sub: user.id, exp: 24.hours.from_now.to_i },
        Rails.application.credentials.secret_key_base || 'development_jwt_secret'
      )
      render json: { message: 'Signed in successfully', token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  # DELETE /api/v1/auth/sign_out
  def sign_out
    if current_user
      render json: { message: 'Signed out successfully' }, status: :ok
    else
      render json: { error: 'User not signed in' }, status: :unauthorized
    end
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

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
