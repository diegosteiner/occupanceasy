# frozen_string_literal: true
require 'rails_helper'

describe '/api/v1/', type: :routing do
  let(:occupiable) { create(:occupiable) }
  let(:base_path) { '/api/v1/' }
  subject { get(path) }

  describe 'occupiables' do
    let(:resource_path) { base_path + 'occupiables/' }

    describe '#show' do
      let(:path) { resource_path + occupiable.to_param }
      it { is_expected.to route_to(json_api_route('api/v1/occupiables#show', id: occupiable.to_param)) }
    end

    describe '/bookings' do
      let(:path) { resource_path + occupiable.to_param + '/bookings' }
      it do
        is_expected.to route_to(
          json_api_related_route('api/v1/bookings', 'api/v1/occupiables', occupiable_id: occupiable.to_param)
        )
      end
    end
  end

  describe 'reservation_requests' do
    let(:resource_path) { base_path + 'reservation-requests/' }
    let(:booking) { create(:reservation_request) }
    let(:path) { resource_path + booking.to_param }

    describe '#show' do
      it { is_expected.to route_to(json_api_route('api/v1/reservation_requests#show', id: booking.to_param)) }
    end

    describe '#update' do
      subject { patch(path) }
      it { is_expected.to route_to(json_api_route('api/v1/reservation_requests#update', id: booking.to_param)) }
    end

    describe '#destroy' do
      subject { delete(path) }
      it { is_expected.to route_to(json_api_route('api/v1/reservation_requests#destroy', id: booking.to_param)) }
    end

    describe '#create' do
      subject { post(resource_path) }
      it { is_expected.to route_to(json_api_route('api/v1/reservation_requests#create')) }
    end
  end

  describe 'manage' do
    let(:base_path) { '/api/v1/manage/' }

    describe 'bookings' do
      let(:resource_path) { base_path + 'bookings/' }
      let(:booking) { create(:reservation) }
      let(:path) { resource_path + booking.to_param }

      describe '#show' do
        it { is_expected.to route_to(json_api_route('api/v1/manage/bookings#show', id: booking.to_param)) }
      end

      describe '#update' do
        subject { patch(path) }
        it { is_expected.to route_to(json_api_route('api/v1/manage/bookings#update', id: booking.to_param)) }
      end

      describe '#destroy' do
        subject { delete(path) }
        it { is_expected.to route_to(json_api_route('api/v1/manage/bookings#destroy', id: booking.to_param)) }
      end

      describe '#create' do
        subject { post(resource_path) }
        it { is_expected.to route_to(json_api_route('api/v1/manage/bookings#create')) }
      end
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
