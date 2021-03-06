namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_posts
    make_categories
    make_tags
    # make_microposts
    # make_relationships
  end
end

def make_posts
  6.times do |n|
    name = Faker::Company.name
    content = Faker::Lorem.sentence(400)
    Post.create!(name: name, content: content, user_id: '1')
  end
end

def make_categories
  Post.all.each do |post|
    1.times do
      name = Faker::Name.last_name
      description = Faker::Lorem.sentence(20)
      post.categories.create!(name: name, description: description)
    end
  end
end

def make_tags
  Post.all.each do |post|
    3.times do
      name = Faker::Name.last_name
      post.tags.create!(name: name)
    end
  end
end

# def make_authors
#   99.times do |n|
#     name  = Faker::Name.name
#     Author.create!(:name => name)
#   end
# end