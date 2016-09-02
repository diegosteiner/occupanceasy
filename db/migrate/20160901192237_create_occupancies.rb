class CreateOccupancies < ActiveRecord::Migration[5.0]
  def change
    create_table :occupancies, id: :uuid do |t|
      t.integer :occupancy_type, null: false, default: 0
      t.string :contact_email, null: true
      t.datetime :begins_at, null: false
      t.datetime :ends_at, null: false
      t.jsonb :additional_data
      t.string :reference
      t.uuid :occupiable_id, foreign_key: true, null: false

      t.timestamps
    end
  end
end
