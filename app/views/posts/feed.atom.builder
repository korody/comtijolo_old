atom_feed do |feed|
  feed.title "comTijolo posts"
  feed.updated @posts.maximum(:updated_at)
  
  @posts.each do |post|
    feed.entry post do |entry|
      entry.title post.name
      entry.content raw post.html
      entry.author do |author|
        author.name post.user.name
      end
    end
  end
end