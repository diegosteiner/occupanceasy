# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Api::V1::Occupiables', type: :request do
  describe 'GET /api_v1_occupiables' do
    it 'works! (now write some real specs)' do
      get api_v1_occupiables_path
      expect(response).to have_http_status(200)
    end
  end
end
