# frozen_string_literal: true
require 'rails_helper'

describe '/api/v1', type: :routing do
  let(:occupiable) { create(:home) }

  describe '/api/v1/occupiables' do
    let(:base_path) { "/api/v1/occupiables/#{occupiable.to_param}/occupancies" }
    it do
      expect(get: base_path).to route_to('api/v1/occupancies#index',
                                         occupiable_id: occupiable.to_param)
      expect(post: base_path).to route_to('api/v1/occupancies#create',
                                          occupiable_id: occupiable.to_param)
    end
  end

  describe 'for occupancies' do
    let(:occupancy) { create(:reservation) }
    let(:base_path) { "/api/v1/occupancies/#{occupancy.to_param}" }
    it do
      expect(get: base_path).to route_to('api/v1/occupancies#show',
                                         id: occupancy.to_param)
    end
  end
end
