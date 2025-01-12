class ResidentsController < ApplicationController

  # include BuilderJsonWebToken::JsonWebToken

  skip_before_action :verify_authenticity_token
 
  def signup
    byebug
    user = Resident.new(resident_params)
    if user.save
      render json: { message: 'User registered successfully.' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # def login
  #   byebug
  #   user = Resident.find_by(email: params[:resident][:email])
  #   if user&.valid_password?(params[:resident][:password])
  #     render json: { account: account, token: encode(account.id) }
  #     token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
  #     render json: { token: token }, status: :ok
  #   else
  #     render json: { error: 'Invalid email or password' }, status: :unauthorized
  #   end
  # end

  def login
    byebug
    email = params[:resident][:email]
    password = params[:resident][:password_digest]

    result = Resident.validate_password(email, password)

    if result[:token]
      render json: result, status: :ok
    else
      render json: result, status: :unauthorized
    end
  end

  private

  def resident_params
    params.require(:resident).permit(:email, :password_digest)
  end

end
