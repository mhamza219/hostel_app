class BookingsController < ApplicationController

  before_action :authenticate_user!

  def create
    booking = Booking.new(booking_params)
    booking.user = current_user
    booking.status = 'pending'

    if booking.save
      render json: booking, status: :created
    else
      render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    if current_user.admin?
      bookings = Booking.all
    else
      bookings = current_user.bookings
    end
    render json: bookings
  end

  def approve
    booking = Booking.find(params[:id])
    booking.update(status: 'approved')
    render json: { message: 'Booking approved' }
  end

  def reject
    booking = Booking.find(params[:id])
    booking.update(status: 'rejected')
    render json: { message: 'Booking rejected' }
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.destroy
    render json: { message: 'Booking cancelled' }
  end

  private

  def booking_params
    params.require(:booking).permit(:room_id, :resident_id, :status)
  end
end
