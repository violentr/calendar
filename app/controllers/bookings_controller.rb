class BookingsController < ApplicationController
  def create
    room = Room.find_by(params[:room_id])
    bookings_conflicting_with_passed_start_date = room.bookings.where(start: params[:start])
    bookings_conflicting_with_passed_end_date = room.bookings.where(end: params[:end])
    if bookings_conflicting_with_passed_start_date.any?
      render json: { message: 'Booking conflicts with an existing booking' }, status: :unprocessable_entity
    elsif bookings_conflicting_with_passed_end_date.any?
      render json: { message: 'Booking conflicts with an existing booking' }, status: :unprocessable_entity
    else
      start_date = Date.parse(params[:start])
      end_date = Date.parse(params[:end])
      room_vacant = true
      while(start_date <= end_date) do
        room.bookings.each do |possibly_conflicting_booking|
          possibly_conflicting_start_date = possibly_conflicting_booking.start
          possibly_conflicting_end_date = possibly_conflicting_booking.end
          while(possibly_conflicting_start_date <= possibly_conflicting_end_date) do
            if possibly_conflicting_start_date == start_date
              room_vacant = false
            end
            possibly_conflicting_start_date += 1.day
          end
        end
        start_date += 1.day
      end
      if room_vacant
        booking = Booking.new(booking_params)
        booking.save

        render json: { message: 'Booking created.' }, status: :ok
      else
        render json: { message: 'Booking conflicts with an existing booking' }, status: :unprocessable_entity
      end
    end
  end

  private

  def booking_params
    params.permit(:start, :end, :room_id)
  end
end
