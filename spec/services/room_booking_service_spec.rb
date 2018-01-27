require 'rails_helper'

RSpec.describe RoomBookingService do
  let(:room) { create(:room) }
  let(:today) { Date.today }

  context 'when booking conflicts with passed start date' do
    before do
      options = {start: today, end: today + 3.days}
      room.bookings.create(options)
      params = {room_id: room.id, start: options[:start].to_s, end: options[:end].to_s}
      @room_booking = described_class.new(params)
      @room_booking.perform
    end

    it 'should return json message, room_vacant is false' do
      expect(@room_booking.room_vacant?).to eq(false)
    end
  end

  context 'when booking conflicts with passed end date' do
    before do
      options = {start: today, end: today + 3.days}
      room.bookings.create(options)
      params = {room_id: room.id, start: options[:start].to_s, end: options[:end].to_s}

      @room_booking = described_class.new(params)
      @room_booking.perform
    end

    it 'should return room_vacant is false' do
      expect(@room_booking.room_vacant?).to eq(false)
    end
  end

  context 'when booking passed start date > passed end date' do
    before do
      options = {start: today, end: today + 3.days}
      3.times {room.bookings.create(options) }
      start_date = (today + 1.week).to_s
      end_date = (today + 5.days).to_s
      params = {room_id: room.id, start: start_date, end: end_date}

      @room_booking = described_class.new(params)
      @room_booking.perform
    end

    it 'should return room vacant is true' do
      expect(@room_booking.room_vacant?).to eq(true)
    end
  end

  context 'when booking passed start date <= passed end date' do
    before do
      options = {start: today + 5.days, end: today + 5.days}
      3.times {room.bookings.create(options) }
      start_date = today.to_s
      end_date = (today + 6.days).to_s
      params = {room_id: room.id, start: start_date, end: end_date }
      @room_booking = described_class.new(params)
      @room_booking.perform
    end

    it 'should return room_vacant is false' do
      expect(@room_booking.room_vacant?).to eq(false)
    end
  end

end
