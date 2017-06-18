class UserRepository < Hanami::Repository
  def auth!(auth_hash)
    info = auth_hash[:info]
    vk_id = info[:uid]
    attrs = {
        first_name:   info[:first_name],
    }

    if (user = users.where(vk_id: attrs[:vk_id]).one)
      user.first_name = attrs[:first_name]
      update user
    else
      create(User.new(attrs.merge(vk_id: vk_id)))
    end
  end
end
