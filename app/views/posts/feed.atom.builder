atom_feed do |feed|
  feed.title "comTijolo"
  feed.updated @posts.maximum(:updated_at)
  
  @posts.each do |post|
    feed.entry post do |entry|
      entry.title post.name
      entry.content raw post.html
      entry.author do |author|
        author.name post.user.name
      end
      entry.link href: post.attachments.first.file_url(:regular), rel:"enclosure", type:"image/jpeg"
      entry.photo image_tag post.attachments.first.file_url(:regular)
      entry.image image_tag post.attachments.first.file_url(:regular)
      entry <<  "<media:thumbnail  xmlns:media='http://search.yahoo.com/mrss/' url='#{post.attachments.first.file_url(:regular)}' height='150' width='300' />"
    end
  end
end