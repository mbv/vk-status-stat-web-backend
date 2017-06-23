class UserRepository < Hanami::Repository
  def auth!(auth_hash)
    info = auth_hash[:info]
    vk_id = auth_hash[:uid]
    attrs = {
        first_name:   info[:first_name],
        info: auth_hash.to_s,
        access_token: auth_hash[:credentials][:token]
    }

    if (user = users.where(vk_id: vk_id).one)
      #user.first_name = attrs[:first_name]
      update user.id, attrs
    else
      create(User.new(attrs.merge(vk_id: vk_id)))
    end
  end

  def friends(user)
    app = VK::Application.new(access_token: user.access_token)
    result = app.friends.get(fields: "first_name, last_name, photo")
    result["items"]
  end
end
