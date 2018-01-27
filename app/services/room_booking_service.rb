class RoomBookingService

  def initialize(params={})
    @room_id = params[:room_id]
    @start_date = params[:start]
    @end_date = params[:end]
    @room_vacant = true
  end

  def perform
   check_availability
  end

  def check_availability
    while(@start_date.to_date <= @end_date.to_date) do
      room.bookings.each do |possibly_conflicting_booking|
        if room_booked.include?(possibly_conflicting_booking)
          return @room_vacant = false
        end
      end
      @start_date = @start_date.to_date + 1.day
    end
  end

  def room_vacant?
    @room_vacant
  end

  def room
    Room.find_by(id: @room_id)
  end

  def room_booked
    room.bookings.where(start: @start_date) + room.bookings.where(end: @end_date)
  end

  def message(status)
    case status
    when :error
      { "message" => 'Booking conflicts with an existing booking'}
    else
      { "message" => 'Booking created.' }
    end
  end
end
