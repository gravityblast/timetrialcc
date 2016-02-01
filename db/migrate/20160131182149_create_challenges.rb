class CreateChallenges < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'

    create_table :challenges, id: :uuid do |t|
      t.integer :user_id,     null: false
      t.string :name,         null: false
      t.integer :segment_id,  null: false
      t.string :segment_name, null: false
      t.timestamp :end_time,   null: false
      t.boolean :calculated,  null: false, default: false

      t.timestamps
    end

    add_index :challenges, :user_id
    add_index :challenges, [:calculated, :end_time]
  end
end
