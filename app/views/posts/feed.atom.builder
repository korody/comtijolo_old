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
      # entry.link href: photo.file.url(:large), rel:"enclosure", type:"image/jpeg"
    end
  end
end