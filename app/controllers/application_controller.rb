class ApplicationController < ActionController::Base

  # include JwtToken

  # skip_before_action :authenticate

  # def authenticate
  #   header = request.headers['Authorization']
  #   header = header.split(' ').last if header
  #   begin
  #     @decoded = jwt_decode(header)
  #     @current_user = Resident.find(@decoded[:user_id])
  #   rescue ActiveRecord::RecordNotFound => e
  #     render json: {errors: e.message}, status: :unauthorized
  #   rescue JWT::DecodeError => e
  #     render json: {errors: e.message}, status: :unauthorized
  #   end
  # end
end
