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
end
