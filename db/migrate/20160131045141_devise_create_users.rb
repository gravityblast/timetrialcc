class DeviseCreateUsers < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :users, id: :uuid do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :name
      t.string :profile_picture_url

      t.timestamps null: false
    end
  end
end
