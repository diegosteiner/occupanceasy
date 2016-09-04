# frozen_string_literal: true
require 'rails_helper'

describe Access do
  describe 'attributes' do
    let(:access) { create(:access) }

    it do
      expect(access).to be_instance_of(Access)
      expect(access.private_key.size).to be > 64
      expect(access.description).not_to be_empty
    end
  end

  describe 'private_key' do
    it do
      access = Access.new(description: 'new access')
      expect(access.save).to be true
      expect(access.private_key.size).to be > 64
    end
  end
end
