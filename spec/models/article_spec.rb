require 'rails_helper'

RSpec.describe Article, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe 'temp_thumbnail_path' do
    it 'return the absolute path to the temporary thumbnail' do
      # TODO
      #article = Article.new(link: "http://google.co.jp")
      #expect(article.temp_thumbnail_path).to eq "#{Dragonfly.app.datastore.root_path}/http-google-co-jp.jpg"
    end
  end

  describe 'image_stored?' do
    it 'if image file is already stored , return true' do
      #article = Article.new(image: "hoge.fuga_image")
    end
  end
end
