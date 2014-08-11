module UsersHelper

  def profile_image_for_index(user)
    url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}"
    image_tag(url, alt: user.name, height: '32', width: '32')
  end

  def profile_image_for_show(user)
    url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}"
    image_tag(url, alt: user.name)
  end


  def profile_image_for(user, options={})
    size = options[:size] || 80
    url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}?s=#{size}"
    image_tag(url, alt: user.name)
  end


end
