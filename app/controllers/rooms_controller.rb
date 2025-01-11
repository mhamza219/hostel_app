class RoomsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :authorize_admin, except: [:index]

  def index
    rooms = Room.where(hostel_id: params[:hostel_id])
    render json: rooms
  end

  def create
    room = Room.new(room_params)
    if room.save
      render json: room, status: :created
    else
      render json: { errors: room.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    room = Room.find(params[:id])
    if room.update(room_params)
      render json: room
    else
      render json: { errors: room.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    render json: { message: 'Room deleted' }
  end

  private

  def room_params
    params.require(:room).permit(:room_number, :capacity, :price, :hostel_id)
  end

  def authorize_admin
    render json: { error: 'Not authorized' }, status: :forbidden unless current_user.admin?
  end

end
