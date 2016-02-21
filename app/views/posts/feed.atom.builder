atom_feed do |feed|
  feed.title "comTijolo"
  feed.updated @posts.maximum(:updated_at)
  
  @posts.each do |post|
    feed.entry post do |entry|
      entry.title post.name
      entry.link post_url(post)
      entry.summary post.description
      entry.content raw post.html  
      entry.author do |author|
        author.name post.user.name
      end
      entry <<  "<media:thumbnail  xmlns:media='http://search.yahoo.com/mrss/' url='#{post.attachments.first.file_url(:regular).to_s}' height='150' width='300' />"
    end
  end
end