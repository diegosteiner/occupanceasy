# frozen_string_literal: true
require 'rails_helper'
require 'support/jsonapi_helper'

shared_examples 'valid occupancies' do
  it { expect(data_ids).to contain_exactly(*occupancies.map(&:id)) }
end

describe Api::V1::OccupiablesController, type: :request do
  let(:occupiable) { create(:home) }

  describe '#show' do
    subject! { get(api_v1_occupiable_path(occupiable), headers: headers) }
    it_behaves_like 'valid response'
  end

  describe '#show/occupancies' do
    let(:params) {}
    let!(:occupancies) { create_list(:reservation, 2, occupiable: occupiable, begins_at: 3.weeks.from_now) }
    subject! { get(api_v1_occupiable_occupancies_path(occupiable), headers: headers, params: params) }

    it_behaves_like 'valid response'
    it { expect(data.count).to be(occupancies.count) }

    describe 'filter' do
      describe 'begins_after' do
        let!(:out_of_range) { create_list(:reservation, 2, occupiable: occupiable, begins_at: 3.months.ago) }
        let(:params) { { 'filter[begins_after]' => Time.zone.now.beginning_of_month.iso8601 } }

        it_behaves_like 'valid response'
        it_behaves_like 'valid occupancies'
      end

      describe 'ends_before' do
        let!(:out_of_range) { create_list(:reservation, 2, occupiable: occupiable, begins_at: 3.months.from_now) }
        let(:params) { { 'filter[ends_before]' => 1.month.from_now.end_of_month.iso8601 } }

        it_behaves_like 'valid response'
        it_behaves_like 'valid occupancies'
      end

      describe 'defaults' do
        let!(:occupancies_out_of_range) do
          [
            create(:reservation, occupiable: occupiable, begins_at: 3.months.ago),
            create(:reservation, occupiable: occupiable, begins_at: 3.years.from_now)
          ]
        end
        let!(:occupancies) { create_list(:reservation, 2, occupiable: occupiable, begins_at: 1.weeks.from_now) }

        it_behaves_like 'valid response'
        it_behaves_like 'valid occupancies'
      end
    end
  end
end
