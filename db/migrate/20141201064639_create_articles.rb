class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :category_id
      t.string :title
      t.string :link
      t.text :description
      # Handling thumbnails
      t.string :photo
      #t.string :image_uid, :default => ''
      #t.string :image_name, :default => '' # if you want urls to end with the original filename
      t.datetime :published

      t.timestamps
    end
  end
end
