# frozen_string_literal: true

CONTENT_TYPE = 'application/vnd.api+json'

def headers(token = nil)
  {
    'HTTP_ACCEPT' => CONTENT_TYPE,
    'HTTP_AUTHORIZATION' => "Token token=#{token}",
    'CONTENT_TYPE' => CONTENT_TYPE
  }
end

def jsonapi_response
  JsonApi::Response.new(response)
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

module JsonApi
  class Response
    attr_reader :response, :parsed_response

    def initialize(response)
      @response = response
      @parsed_response = JSON.parse(response.body, object_class: OpenStruct)
    end

    def ok?
      [200, 201].include?(@response.status)
    end

    def data
      @parsed_response.data
    end
  end
end
