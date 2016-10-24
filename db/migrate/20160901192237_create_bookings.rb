class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings, id: :uuid do |t|
      t.string :contact_email, null: true
      t.datetime :begins_at, null: false, index: true
      t.datetime :ends_at, null: false, index: true
      t.jsonb :additional_data
      t.string :reference
      t.uuid :occupiable_id, foreign_key: true, null: false
      t.integer :booking_type, null: false, index: true
      t.boolean :blocking, index: true, default: false
      t.boolean :begins_at_specific_time, default: true
      t.boolean :ends_at_specific_time, default: true

      t.timestamps
    end
  end
end
