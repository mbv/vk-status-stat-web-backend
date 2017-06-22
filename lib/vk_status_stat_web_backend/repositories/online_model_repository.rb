class OnlineModelRepository < Hanami::Repository
  def for_user(user_id)
    online_models.where(user_id: user_id).order(:changed_at)
  end
end
