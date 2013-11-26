class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :youtubeid
      t.string :bloglink
      t.string :source

      t.timestamps
    end
  end
end
