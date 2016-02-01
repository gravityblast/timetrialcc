class AddPolylineToChallenges < ActiveRecord::Migration[5.0]
  def change
    add_column :challenges, :segment_polyline, :text
    add_column :challenges, :segment_start_latlng, :string
    add_column :challenges, :segment_end_latlng, :string
  end
end
