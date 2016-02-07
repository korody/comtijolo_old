# encoding: UTF-8
namespace :db do

  desc "transform content to html"
  task generate_html: :environment do
    Post.all.each do |post|
      post.cook_html
      post.save
    end
  end
end