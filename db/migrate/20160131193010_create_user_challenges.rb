class CreateUserChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :user_challenges do |t|
      t.integer   :user_id
      t.uuid      :challenge_id
      t.datetime  :created_at
    end

    add_index :user_challenges, [:user_id, :challenge_id], unique: true
  end
end
