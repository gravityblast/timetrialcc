class AddMovingTimeToUserChallenges < ActiveRecord::Migration[5.0]
  def change
    add_column :user_challenges, :moving_time, :integer
  end
end
