require 'dragonfly'
require 'stringio'
class Article < ActiveRecord::Base
  # you can add the Dragonfly attatchment methods image and image=
  extend Dragonfly::Model
  # Let's say you have ha model with methods image_uid and image_uid=
  #attr_accessor :image_uid
  dragonfly_accessor :image # defines a reader/writer for image

  #Generate thumnail on validate so we can return errors on failure
  after_create :generate_thumbnail_from_url

  #Cleanup temp files when we are done
  after_save :cleanup_temp_thumbnail

  # Generate a thumbnail from the remote URL
  def generate_thumbnail_from_url
  
    # Skip thumbnail generation if:
    # a) there are already other validation errors
    # b) an image was manually specified
    # c) an image is already stored and the URL hasn't changed
      #skip_generate = self.errors.any? || (self.image_changed? ||
      skip_generate = self.errors.any? || self.image_stored?
      #               (self.image_stored? && !self.url_changed?))
    # p "*** generating thumbnail: #{!skip_generate}"
    return if skip_generate
  
    # Generate and assign an image or set a validation error
    begin
      tempfile = temp_thumbnail_path
      cmd = "wkhtmltoimage --quality 50 --width 300 --height 300 \"#{self.link}\" \"#{tempfile}\""
         p "*** grabbing thumbnail: #{cmd}"
      system(cmd) # sometimes returns false even if image was saved
      self.image = File.new(tempfile) # will throw if not saved
      self.save
    rescue => e
         p "*** thumbnail error: #{e}"
      self.errors.add(:base, "Cannot generate thumbnail. Is your URL valid?")
    ensure
    end
  end

  # Return the absolute path to the temporary thumbnail file
  def temp_thumbnail_path
    File.expand_path("#{self.link.parameterize.slice(0, 20)}.jpg", Dragonfly.app.datastore.root_path)
  end

  # Cleanup the temporary thumbnail image
  def cleanup_temp_thumbnail
    File.delete(temp_thumbnail_path) rescue 0
  end

  # check if file is already stored
  def image_stored?
    self.image.present?
  end

 # 
 #= return articles as array of hash
 #
 def self.list(request)
   res = Array.new
   Article.all.each do |article|
     res.push({
       :category_id => article.category_id,
       :title => article.title,
       :link => article.link,
       :description => article.description,
       :image_url => "#{request.protocol}#{request.host_with_port}#{article.image.url}",
     })
   end
   res
 end
end
