class CreateUserChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :user_challenges, id: :uuid do |t|
      t.uuid      :user_id
      t.uuid      :challenge_id
      t.datetime  :created_at
    end

    add_index :user_challenges, [:user_id, :challenge_id], unique: true
  end
end
