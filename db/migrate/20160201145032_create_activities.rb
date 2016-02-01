class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.integer  "event_id"
      t.string   "event_name"
      t.integer  "recipient_id"
      t.string   "originator_type"
      t.integer  "originator_id"
      t.string   "subject_type"
      t.integer  "subject_id"
      t.datetime "event_created_at"
      t.timestamps
    end

    add_index :activities, :recipient_id
    add_index :activities, :event_created_at
  end
end
