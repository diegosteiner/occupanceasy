# frozen_string_literal: true
class Access < ApplicationRecord
  before_create do
    self.private_key ||= SecureRandom.urlsafe_base64(64)
  end

  has_many :occupiables
end
