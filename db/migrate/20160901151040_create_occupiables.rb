class CreateOccupiables < ActiveRecord::Migration[5.0]
  def change
    create_table :occupiables, id: :uuid do |t|
      t.string :description
      t.uuid :access_id, foreign_key: true
      t.timestamps
    end
  end
end
