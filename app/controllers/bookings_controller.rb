class BookingsController < ApplicationController
  def create
    room_booking = RoomBookingService.new(params)
    room_booking.perform
    if room_booking.room_vacant?
      booking = Booking.new(booking_params)
      booking.save
      render json: room_booking.message(:success), status: :ok
    else
      render json: room_booking.message(:error), status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.permit(:start, :end, :room_id)
  end
end
