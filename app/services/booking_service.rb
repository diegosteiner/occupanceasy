class BookingService
  attr_reader :occupiable

  def initialize(occupiable)
    @occupiable = occupiable
  end

  def upcoming_occupancies
    occupiable.occupancies.upcoming
  end
end
