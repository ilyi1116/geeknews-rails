class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer :category_id
      t.string :name
      t.string :url
      t.timestamp :last_fetched

      t.timestamps
    end
    add_index :feeds, :url , :unique => true
  end
end
