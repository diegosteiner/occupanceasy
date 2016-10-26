# frozen_string_literal: true

CONTENT_TYPE = 'application/vnd.api+json'

def headers(token = nil)
  {
    'HTTP_ACCEPT' => CONTENT_TYPE,
    'HTTP_AUTHORIZATION' => "Token token=#{token}",
    'CONTENT_TYPE' => CONTENT_TYPE
  }
end

def parsed_json
  JSON.parse(response.body)
end

def data
  parsed_json['data']
end

def data_ids
  data.map { |item| item['id'] }
end

shared_examples 'valid response' do
  it { expect(response.content_type).to eq(CONTENT_TYPE) }
  it { expect(response.status).to be 200 }
end

shared_examples 'not found response' do
  it { expect(response.content_type).to eq(CONTENT_TYPE) }
  it { expect(response.status).to be 404 }
end

shared_examples 'unauthorized response' do
  it { expect(response.content_type).to eq(CONTENT_TYPE) }
  it { expect(response.status).to be 403 }
end

class JsonApiHelper
  def booking_to_jsonapi(booking, type = :bookings)
    attributes = booking.attributes.slice('begins_at', 'ends_at', 'contact_email', 'booking_type')
    relationships = { occupiable: { data: { type: :occupiables, id: booking.occupiable_id } } }
    { data: { id: booking.to_param, type: type, attributes: attributes, relationships: relationships } }.to_json
  end
end
