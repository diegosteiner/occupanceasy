class PublicOccupancySerializer < ApplicationSerializer
  attributes :id, :begins_at, :ends_at
  belongs_to :occupiable
end
