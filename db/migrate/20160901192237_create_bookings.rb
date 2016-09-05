class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings, id: :uuid do |t|
      t.string :type, null: false, index: true, default: ReservationRequest.sti_name
      t.string :contact_email, null: true
      t.datetime :begins_at, null: false, index: true
      t.datetime :ends_at, null: false, index: true
      t.jsonb :additional_data
      t.string :reference
      t.uuid :occupiable_id, foreign_key: true, null: false
      t.boolean :blocking, index: true, default: false

      t.timestamps
    end
  end
end
