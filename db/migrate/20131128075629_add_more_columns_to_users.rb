class AddMoreColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :link, :string
    add_column :users, :location_name, :string
    add_column :users, :gender, :string
    add_column :users, :timezone, :decimal
  end
end
