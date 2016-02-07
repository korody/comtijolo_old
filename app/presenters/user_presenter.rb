class UserPresenter < BasePresenter
  attr_reader :user

  def initialize(user, view_context)
    @user = user
    @view_context = view_context
    @attachments = user.attachments
    @videos = user.videos
  end

  def name
    user.name
  end


  def first_attachment
    @attachments.first
  end

  def other_attachments
    @attachments.drop(1)
  end

  def bio
    h.raw(user.bio).gsub(/\n/, '<br/>').html_safe
  end

  def videos
    @videos.each do |video|
      video
    end
  end
end
