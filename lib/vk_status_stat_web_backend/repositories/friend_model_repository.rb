class FriendModelRepository < Hanami::Repository
  def friend_list(user_id)
    friend_models.where(user_id: user_id).order(:friend_id, Sequel.lit("? DESC", :created_at))
  end
end
