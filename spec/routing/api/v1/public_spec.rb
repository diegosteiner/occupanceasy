# frozen_string_literal: true
require 'rails_helper'

describe '/api/v1/public', type: :routing do
  PATH = '/api/v1/public'
  let!(:occupiable) { create(:occupiable) }

  describe "occupiables" do
    describe '#show' do
      let(:path) { "#{PATH}/occupiables/#{occupiable.to_param}" }
      it do
        expect(get: path).to route_to('api/v1/public/occupiables#show',
                                      id: occupiable.to_param)
      end
    end

    describe '#occupancies' do
      let(:path) { "#{PATH}/occupiables/#{occupiable.to_param}/bookings" }
      it do
        expect(get: path).to route_to(
          relationship: 'bookings',
          source: 'api/v1/public/occupiables',
          action: 'get_related_resources',
          controller: 'api/v1/public/bookings',
          occupiable_id: occupiable.to_param
        )
      end
    end
  end
end
