class HostelsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:create, :update, :destroy]

  def index
    hostels = Hostel.all
    render json: hostels
  end

  def create
    hostel = Hostel.new(hostel_params)
    if hostel.save
      render json: hostel, status: :created
    else
      render json: { errors: hostel.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    hostel = Hostel.find(params[:id])
    if hostel.update(hostel_params)
      render json: hostel
    else
      render json: { errors: hostel.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    hostel = Hostel.find(params[:id])
    hostel.destroy
    render json: { message: 'Hostel deleted' }
  end

  private

  def hostel_params
    params.require(:hostel).permit(:hostel_name, :address, :pincode, :contact_number, :ratings, :description)
  end

  def authorize_admin
    render json: { error: 'Not authorized' }, status: :forbidden unless current_user.admin?
  end

end