#coding: utf-8
require 'pp'
require 'net/http'
require 'uri'
require 'rexml/document'

module Tasks
  class ArticlePicker
    # initialize article data
    def self.execute
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE articles")
  
      feed_list = Feed.all
      articles = []
  
      feed_list.each do |feed|
        next if feed.url.blank?
        articles = fetch_and_parse(feed.url)
        save_articles(articles, feed.category_id)
      end
    end
  
    # save articles
    def self.save_articles(articles, category_id)
      return if articles.empty?
      pp '--'
      pp Time.now
  
      articles.each do |article|
      #pp sprintf('save %s of %d', article['title'], category_id)
      pp sprintf('save %s of %d', article['link'], category_id)

        Article.create!(
          :category_id => category_id,
          :title => article['title'], 
          :link => article['link'], 
          :description => article['description'], 
        )

      end
    end
  
    # return parsed articles
    def self.fetch_and_parse(url)
      res = fetch(url)
      articles = xml_to_array(res)
      pp articles
      articles
    end
  
  
    # fetch response from url
    def self.fetch(url)
      pp URI.escape(url)
  
      uri = URI.parse URI.escape(url)
      res = Net::HTTP.get uri
  
      res
    end
  
    # return parsed XML
    def self.xml_to_array(xml)
      items_rx = []
      doc = REXML::Document.new xml
      doc.elements.each('//item') do |e|
        i = Hash.new
        i["title"] = e.elements['title'].text
        i["link"] = e.elements['link'].text
        i["description"] = e.elements['description'].text
        items_rx << i
      end
  
      return items_rx
  
    end
  
  end
end
