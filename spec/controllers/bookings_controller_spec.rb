require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let(:room) { create(:room) }
  let(:today) { Date.today }

  def json_parser(json)
    JSON.parse(json)
  end

   describe '#create' do

     context 'when booking conflicts with passed start date' do
       before do
         options = {start: today.to_s, end: (today + 3.days).to_s}
         room.bookings.create(options)
         params = {room_id: room.id}.merge(options)

         post :create, params: params, format: :json
       end

       it 'should return unprocessable_entity' do
         expect(response).to have_http_status(422)
       end

       it 'should return json message, "Booking conflicts with an existing booking"' do
         message = {"message" => "Booking conflicts with an existing booking"}
         output = json_parser(response.body)
         expect(output).to eq(message)
       end
     end

     context 'when booking conflicts with passed end date' do
       before do
         options = {start: today.to_s, end: (today + 3.days).to_s}
         room.bookings.create(options)
         params = {room_id: room.id}.merge(options)

         post :create, params: params, format: :json
       end

       it 'should return unprocessable_entity' do
         expect(response).to have_http_status(422)
       end

       it 'should return json message Booking conflicts with an existing booking' do
         message = {"message" => "Booking conflicts with an existing booking"}
         output = json_parser(response.body)
         expect(output).to eq(message)
       end
     end

     context 'when booking passed start date > passed end date' do
       before do
         options = {start: today.to_s, end: (today + 3.days).to_s}
         3.times {room.bookings.create(options) }
         start_date = (today + 1.week).to_s
         end_date = (today + 5.days).to_s
         params = {room_id: room.id}.merge(start: start_date, end: end_date)

         post :create, params: params , format: :json
       end

       it 'should create booking' do
         expect(response).to have_http_status(:success)
       end

       it 'should return json message "Booking created"' do
         message = {"message" => "Booking created."}
         output = json_parser(response.body)
         expect(output).to eq(message)
       end
     end

     context 'when booking passed start date <= passed end date' do
       before do
         options = {start: (today + 5.days).to_s, end: (today + 5.days).to_s}
         3.times {room.bookings.create(options) }
         params = {room_id: room.id}.merge(options)
         post :create, params: params, format: :json
       end

       it 'should return json http_error unprocessable_entity' do
         expect(response).to have_http_status(:unprocessable_entity)
       end

       it 'should return json message "Booking conflicts with an existing booking"' do
         message = {"message" => "Booking conflicts with an existing booking"}
         output = json_parser(response.body)
         expect(output).to eq(message)
       end
     end
   end
end
