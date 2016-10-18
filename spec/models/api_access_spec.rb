# frozen_string_literal: true
require 'rails_helper'

describe ApiAccess, type: :model do
  describe 'attributes' do
    let(:access) { create(:api_access) }

    it do
      expect(access).to be_instance_of(ApiAccess)
      expect(access.private_key.size).to be > 64
      expect(access.description).not_to be_empty
    end
  end

  describe 'private_key' do
    it do
      access = described_class.new(description: 'new access')
      expect(access.save).to be true
      expect(access.private_key.size).to be > 64
    end
  end
end
