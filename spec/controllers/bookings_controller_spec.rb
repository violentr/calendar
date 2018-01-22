require 'rails_helper'

RSpec.describe BookingsController, type: :controller do

  def json_parser(json)
    JSON.parse(json)
  end

   describe '#create' do

     context 'when booking conflicts with passed start date' do
       before do
         @room = create(:room)
         @options = {start: Date.today, end: Date.today + 3.days}
         @room.bookings.create(@options)
       end
       it 'should return unprocessable_entity' do

         post :create, {room_id: @room.id, start: @options[:start].to_s}, format: :json
         expect(response).to have_http_status(422)
       end
       it 'should return json message' do

         post :create, {room_id: @room.id, start: @options[:start].to_s}, format: :json
         message = {"message" => "Booking conflicts with an existing booking"}
         output = json_parser(response.body)
         expect(output).to eq(message)
       end
     end

     context 'when booking conflicts with passed end date' do
       before do
         @room = create(:room)
         @options = {start: Date.today, end: Date.today + 3.days}
         @room.bookings.create(@options)
       end
       it 'should return unprocessable_entity' do

         post :create, {room_id: @room.id, end: @options[:end].to_s}, format: :json
         expect(response).to have_http_status(422)
       end
       it 'should return json message' do

         post :create, {room_id: @room.id, end: @options[:end].to_s}, format: :json
         message = {"message" => "Booking conflicts with an existing booking"}
         output = json_parser(response.body)
         expect(output).to eq(message)
       end
     end
   end
end
