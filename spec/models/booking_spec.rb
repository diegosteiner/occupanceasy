# frozen_string_literal: true
require 'rails_helper'

describe Booking, type: :model do
  let(:booking) { create(:booking) }
  let(:home) { create(:home) }

  describe 'attributes' do
    it do
      expect(booking).to be_a(Booking)
      expect(booking.occupiable).to be_instance_of(Occupiable)
      expect(booking.contact_email).not_to be_empty
      expect(booking.begins_at_specific_time).to be true
      expect(booking.ends_at_specific_time).to be true
    end
  end

  describe '#public_token' do
    it { expect(booking.public_token.size).to be > 40 }
  end

  describe 'factory' do
    it do
      booking = create(:booking)
      expect(booking).to be_valid
      expect(booking.save).to eq true
    end
  end

  describe 'validations' do
    it do
      booking = Booking.new(booking_type: Booking.booking_types[:reservation])
      expect(booking).not_to be_valid
      booking.occupiable = create(:home)
      booking.begins_at = 1.week.from_now
      expect(booking).not_to be_valid
      booking.ends_at = 1.day.from_now
      expect(booking).not_to be_valid
      booking.ends_at = 2.weeks.from_now
      expect(booking).to be_valid
      expect(booking.save).to eq(true)
    end
  end

  describe '#range' do
    it do
      expect(booking.range.begin).to eq(booking.begins_at)
      expect(booking.range.end).to eq(booking.ends_at)
    end
  end

  describe '#versions' do
    subject { booking.versions }
    let(:updated_booking) { attributes_for(:booking) }
    it versioning: true do
      with_versioning do
        expect(PaperTrail).to be_enabled
        is_expected.to have_attributes(count: 1)
        booking.update(contact_email: updated_booking[:contact_email])
        is_expected.to have_attributes(count: 2)
      end
    end
  end

  describe 'scopes' do
    describe 'overlapping' do
      subject { Booking.overlapping(booking.range).map(&:id) }
      it { is_expected.to eq([booking.id]) }
    end

    describe 'occupancies' do
      let!(:reservation_requests) { create_list(:reservation_request, 2) }
      let!(:reservations) { create_list(:reservation, 2) }
      let!(:closedowns) { create_list(:closedown, 2) }
      subject { Booking.occupancies }
      it { is_expected.to contain_exactly(*[reservations, closedowns].flatten) }
    end

    describe 'upcoming' do
      let!(:upcoming) { create_list(:reservation, 2, begins_at: 2.days.from_now) }
      let!(:current) { create_list(:reservation, 2, begins_at: 2.days.ago, ends_at: 2.days.from_now) }
      let!(:over) { create_list(:reservation, 2, begins_at: 4.days.ago, ends_at: 2.days.ago) }
      subject { Booking.upcoming }
      it { is_expected.to contain_exactly(*(upcoming + current)) }
    end
  end
end
