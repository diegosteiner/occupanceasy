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
        
      describe '#index' do
        it { is_expected.to route_to(json_api_route('api/v1/bookings#index', occupiable_id: occupiable.to_param)) }
      end

      describe '#show' do
        let(:reservation) { create(:reservation, occupiable: occupiable) }
        let(:path) { resource_path + occupiable.to_param + '/bookings' + "/#{reservation.to_param}" }
        it do
          is_expected.to route_to(json_api_route('api/v1/bookings#show', 
                                                 occupiable_id: occupiable.to_param, 
                                                 id: reservation.to_param
                                                )) 
        end
      end

      describe '#create' do
        subject { post(path) }
        it { is_expected.to route_to(json_api_route('api/v1/bookings#create', occupiable_id: occupiable.to_param)) }
      end

      xdescribe '#update' do
        subject { patch(path) }
        it { is_expected.to route_to(json_api_route('api/v1/reservation_requests#update', id: booking.to_param)) }
      end

      xdescribe '#destroy' do
        subject { delete(path) }
        it { is_expected.to route_to(json_api_route('api/v1/reservation_requests#destroy', id: booking.to_param)) }
      end
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

    describe 'occupiables' do
      let(:resource_path) { base_path + 'occupiables/' }
      let(:occupiable) { create(:home) }
      let(:path) { resource_path + occupiable.to_param }

      describe '#show' do
        it { is_expected.to route_to(json_api_route('api/v1/manage/occupiables#show', id: occupiable.to_param)) }
      end

      describe '#update' do
        subject { patch(path) }
        it { is_expected.to route_to(json_api_route('api/v1/manage/occupiables#update', id: occupiable.to_param)) }
      end

      describe '#destroy' do
        subject { delete(path) }
        it { is_expected.to route_to(json_api_route('api/v1/manage/occupiables#destroy', id: occupiable.to_param)) }
      end

      describe '#create' do
        subject { post(resource_path) }
        it { is_expected.to route_to(json_api_route('api/v1/manage/occupiables#create')) }
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

def json_api_related_route(relationship, controller, source, params = {})
  {
    relationship: relationship || controller.split('/').last,
    source: source
  }.merge(json_api_route("#{controller}#get_related_resources", params))
end
