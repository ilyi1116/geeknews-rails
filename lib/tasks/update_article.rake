#
## usage for development:
##   RAILS_ENV=development rake update_article:execute
require 'pp'
require "#{Rails.root}/lib/tasks/article_picker.rb"
namespace :update_article do
  desc "this task is called by cron or whenever"
  task execute: :environment do

    retry_count = 0

    begin
      pp "updating article ..."
      Tasks::ArticlePicker.execute
    rescue Exception => e
      pp "[ERROR] update_article #{e.message}"
      retry_count += 1
      #retry if retry_count <= 5
      #pp "retried 5 times so exit"
      exit
    end
    pp "updated article"
    
  end

end
