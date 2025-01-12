class ResidentsController < ApplicationController

  # include BuilderJsonWebToken::JsonWebToken

  skip_before_action :verify_authenticity_token

  include JwtToken
 
  def signup
    # byebug
    user = Resident.new(resident_params)
    if user.save
      render json: { message: 'User registered successfully.' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    byebug
    @user = Resident.find_by(email: params[:resident][:email])
    if @user&.authenticate(params[:resident][:password_digest])
      token = jwt_encode(user_id: @user.id)
      time = (Time.now + 24.hours)
      render json: {
        token: token,
        exp: time.strftime("%m-%d-%Y %H:%M"),
        username: @user.username
      }, status: :ok
    else
      render json: {error: 'unauthorized'}, status: :unauthorized
    end
  end

  def authenticate
    # byebug
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = jwt_decode(header)
      @current_user = Resident.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: {errors: e.message}, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: {errors: e.message}, status: :unauthorized
    end
  end

  # def login
  #   byebug
  #   user = Resident.find_by(email: params[:resident][:email])
  #   if user(params[:resident][:password])
  #     render json: { account: user, token: encode(user.id) }
  #     token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
  #     render json: { token: token }, status: :ok
  #   else
  #     render json: { error: 'Invalid email or password' }, status: :unauthorized
  #   end
  # end

  # def login
  #   byebug
  #   email = params[:resident][:email]
  #   password = params[:resident][:password_digest]

  #   result = Resident.validate_password(email, password)

  #   if result[:token]
  #     render json: result, status: :ok
  #   else
  #     render json: result, status: :unauthorized
  #   end
  # end

  private

  def resident_params
    params.require(:resident).permit(:email, :password_digest)
  end

end
