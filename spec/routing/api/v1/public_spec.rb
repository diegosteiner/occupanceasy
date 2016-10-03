# frozen_string_literal: true
require 'rails_helper'

describe '/api/v1/', type: :routing do
  BASE_PATH = '/api/v1'
  let(:occupiable) { create(:occupiable) }

  describe 'occupiables/' do
    describe '#show' do
      subject { get("#{BASE_PATH}/occupiables/#{occupiable.to_param}") }
      it { is_expected.to route_to(json_api_route('api/v1/occupiables#show', id: occupiable.to_param)) }
    end

    describe '/bookings' do
      subject { get("#{BASE_PATH}/occupiables/#{occupiable.to_param}/bookings") }
      it do
        is_expected.to route_to(
          json_api_related_route('api/v1/bookings', 'api/v1/occupiables', occupiable_id: occupiable.to_param)
        )
      end
    end
  end

  describe 'bookings/' do
    let(:booking) { create(:reservation) }

    describe '#show' do
      subject { get("#{BASE_PATH}/bookings/#{booking.to_param}") }
      it { is_expected.to route_to(json_api_route('api/v1/bookings#show', id: booking.to_param)) }
    end
  end
end

def json_api_route(controller_action, params = {})
  controller, action = controller_action.split('#')
  {
    controller: controller,
    action: action
  }.merge(params)
end

def json_api_related_route(controller, source, params = {})
  {
    relationship: controller.split('/').last,
    source: source
  }.merge(json_api_route("#{controller}#get_related_resources", params))
end
