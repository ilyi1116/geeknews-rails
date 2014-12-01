require 'rails_helper'

RSpec.describe Article, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe 'temp_thumbnail_path' do
    it 'return the absolute path to the temporary thumbnail' do
      article = Article.new(image_url: "hoge.fuga_image")
      expect(article.temp_thumbnail_path).to eq "#{Dragonfly.app.datastore.root_path}/hoge-fuga_image.jpg"
    end
  end
end
