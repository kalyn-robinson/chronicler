module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  # Find user by case-insensitive attribute.
  def find_users(attribute, value)
    User.where("lower(#{attribute}) = ?", value.downcase)
  end

  # Find user by case-insensitive name.
  def find_user_by_name(name)
    find_users('name', name).first
  end
end
