# frozen_string_literal: true
require 'rails_helper'

RSpec.describe BookingService do
  let(:occupiable) { create(:occupiable) }
  let(:service) { described_class.new(occupiable) }

  describe '#initialize' do
    subject { service.occupiable }
    it { is_expected.to eq(occupiable) }
  end

  describe '#reservation_request' do
    let(:attributes) { attributes_for(:reservation_request) }
    subject { service.reservation_request(attributes) }
    it { is_expected.to be_a(Booking) }
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

  describe '#with_token' do
    let(:booking) { create(:reservation) }
    subject { service.with_token(booking.to_param) }

    context 'with accessable booking' do
      it { is_expected.to eq(booking) }
    end

    context 'with inaccessable booking' do
      let(:booking) { create(:closedown) }
      it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end
end
