class ResidentsController < ApplicationController
 
  def signup
    user = Resident.new(resident_params)
    if user.save
      render json: { message: 'User registered successfully.' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = Resident.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def resident_params
    params.require(:resident).permit(:email, :password_digest)
  end

end
