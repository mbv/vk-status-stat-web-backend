class VKRepository
  def friends(user)
    app = VK::Application.new(access_token: user.access_token)
    result = app.friends.get(fields: "first_name, last_name, photo")
    result["items"]
  end

  def user(user_id)
    app = VK::Application.new(access_token: "b6c7d77ab6c7d77ab6c7d77a55b69b4be3bb6c7b6c7d77aeffb36e5c2305e428ee15bd7")
    result = app.users.get(user_id: user_id, fields: "first_name, last_name")
    result.first
  end
end