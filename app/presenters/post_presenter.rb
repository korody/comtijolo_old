class PostPresenter < BasePresenter
  attr_reader :post

  def initialize(post, view_context)
    @post = post
    @view_context = view_context
    @attachments = post.attachments
    @categories = post.categories
    @videos = post.videos
    @collections = post.collections
    @tags = post.tags
  end

  def name
    post.name
  end

  def name_link
    h.link_to name, post
  end

  def creation
    h.l post.created_at, format: :date_month
  end

  def author
    post.user
  end

  def categories
    h.raw @categories.pluck(:name).map { |c| h.link_to c, h.category_path(c.parameterize), class: 'category-link' }.join(', ')
  end

  def first_attachment
    @attachments.first
  end

  def other_attachments
    @attachments.drop(1)
  end

  def content
    h.raw post.html
  end

  def videos
    @videos.each do |video|
      video
    end
  end

  def collections
    @collections
  end

  def collections_list
    h.raw @collections.pluck(:name).map { |c| h.link_to c, h.collection_path(c.parameterize), class: 'collection-link' }.join(', ')
  end

  def tags
    @tags
  end

  def tags_list
    h.raw @tags.pluck(:name).map { |t| h.link_to t, h.tag_path(t.parameterize), class: 'tag-link' }.join(', ')
  end

  def comments
    h.link_to post.name, h.polymorphic_path([post], anchor: 'disqus_thread'), class: 'comment-count'
  end

  def recommend
    if post.recommended?
      h.link_to h.icon_tag('star'), h.unrecommend_post_path(post), class: 'actions-link', data: { confirm: "Remover recomendação?" }, method: :patch
    else
      h.link_to h.icon_tag('star-o'), h.recommend_post_path(post), class: 'actions-link', data: { confirm: "Recomendar post?" }, method: :patch
    end  
  end
end
