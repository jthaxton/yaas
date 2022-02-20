class CreateAllowedOrigins < ActiveRecord::Migration[7.0]
  def change
    create_table :allowed_origins, id: :uuid do |t|
      t.string :url, null: false
      t.timestamps
    end

    change_table :users do |t|
      t.uuid :allowed_origin_id, null: false
    end
    add_index :users, :allowed_origin_id
    add_index :allowed_origins, :id, unique: true
  end
end
