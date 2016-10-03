# frozen_string_literal: true
require 'rails_helper'

# describe OccupancySerializer do
#   let(:occupancy) { create(:reservation) }
#   let(:serializer) { described_class.new(occupancy) }
#   let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
#   let(:json) { serialization.to_json }
#   subject(:parsed_json) { JSON.parse(json) }

#   it { is_expected.to have_key('data') }

#   describe '["data"]' do
#     subject(:data) { parsed_json['data'] }
#     it { is_expected.to have_key('attributes') }
#     it { is_expected.to have_key('relationships') }
#     it do
#       is_expected.to include(
#         'id' => occupancy.id,
#         'type' => 'reservations'
#       )
#     end

#     describe '["attributes"]' do
#       subject(:attributes) { data['attributes'] }
#       it do
#         is_expected.to include(
#           'contact_email' => occupancy.contact_email,
#           'created_at' => occupancy.created_at.iso8601(3),
#           'updated_at' => occupancy.updated_at.iso8601(3),
#           'begins_at' => occupancy.begins_at.iso8601(3),
#           'ends_at' => occupancy.ends_at.iso8601(3)
#         )
#       end

#       describe 'additional_data' do
#         let(:occupancy) { create(:reservation_with_additional_data) }
#         it do
#           is_expected.to include(
#             'name' => occupancy.additional_data['name'],
#             'organization' => occupancy.additional_data['organization']
#           )
#         end
#       end
#     end

#     describe '["relationships"]' do
#       subject(:relationships) { data['relationships'] }
#       it { is_expected.to have_key('occupiable') }
#     end
#   end
# end
