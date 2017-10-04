# frozen_string_literal: true

require 'rails_helper'

describe Occupiable, type: :model do
  let(:occupiable) { create(:home) }

  describe 'attributes' do
    it do
      expect(occupiable).to be_instance_of(Occupiable)
      expect(occupiable.api_access).to be_instance_of(ApiAccess)
      expect(occupiable.description).not_to be_empty
    end
  end

  xdescribe 'occupancies' do
    let!(:occupancies) { create_list(:reservation, 2, occupiable: occupiable) }
    let!(:reservation_requests) { create_list(:reservation_request, 2, occupiable: occupiable) }
    subject { occupiable.occupancy_ids }

    it { is_expected.to contain_exactly(*occupancies.map(&:id)) }
  end
end
