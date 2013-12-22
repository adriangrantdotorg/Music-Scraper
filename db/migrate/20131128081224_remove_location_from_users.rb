class RemoveLocationFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :location_name, :string
  end
end
