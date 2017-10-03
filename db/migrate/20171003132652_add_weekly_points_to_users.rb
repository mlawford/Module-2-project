class AddWeeklyPointsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :weekly_points, :integer, :default => 0
  end
end
