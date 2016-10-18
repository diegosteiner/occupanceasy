class CreateAccesses < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'
    create_table :api_accesses, id: :uuid do |t|
      t.string :private_key, null: false
      t.string :description

      t.timestamps
    end
  end
end
