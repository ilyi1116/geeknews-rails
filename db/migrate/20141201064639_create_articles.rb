class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :image_url

      t.timestamps
    end
  end
end
