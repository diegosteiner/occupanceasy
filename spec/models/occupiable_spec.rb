# frozen_string_literal: true
require 'rails_helper'

describe Occupiable do
  describe 'attributes' do
    let(:occupiable) { create(:home) }
    it do
      expect(occupiable).to be_instance_of(Occupiable)
      expect(occupiable.access).to be_instance_of(Access)
      expect(occupiable.description).not_to be_empty
    end
  end
end
