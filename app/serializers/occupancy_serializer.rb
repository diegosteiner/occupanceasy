# frozen_string_literal: true
class OccupancySerializer < ApplicationSerializer
  attributes :id, :begins_at, :ends_at, :created_at, :updated_at, :contact_email
  belongs_to :occupiable

  def attributes(attrs)
    additional_data = object.additional_data || {}
    additional_data.merge(super(attrs))
  end
end
