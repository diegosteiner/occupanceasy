class OccupancySerializer < ApplicationSerializer
  attributes :id, :begins_at, :ends_at, :created_at, :updated_at, :contact_email
  belongs_to :occupiable
end
