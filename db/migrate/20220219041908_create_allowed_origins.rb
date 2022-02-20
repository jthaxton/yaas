class CreateAllowedOrigins < ActiveRecord::Migration[7.0]
  def change
    create_table :allowed_origins, id: :uuid do |t|
      t.string :url, null: false
      t.timestamps
    end
  end
end
