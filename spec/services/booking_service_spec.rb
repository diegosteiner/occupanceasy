require 'rails_helper'

RSpec.describe BookingService do
  let(:occupiable) { create(:occupiable) }
  let(:service) { described_class.new(occupiable) }

  describe '#initialize' do
    subject { service.occupiable }
    it { is_expected.to eq(occupiable) }
  end

  describe '#upcoming_occupancies' do
    let!(:upcoming_occupancies) { create_list(:reservation, 3, occupiable: occupiable, begins_at: 2.days.from_now) }
    let!(:other_occupancies) do
      [
        create(:reservation_request, occupiable: occupiable),
        create(:reservation, occupiable: occupiable, begins_at: 4.days.ago, ends_at: 2.days.ago)
      ]
    end
    subject { service.upcoming_occupancies }

    it { is_expected.to contain_exactly(*upcoming_occupancies) }
  end
end
