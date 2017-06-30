module Web::Controllers::User
  class Show
    include Web::Action

    expose :user, :friends, :user_models


    def call(params)
      @user = UserModelRepository.new.find(params[:id])
      unless @user
        user = VKRepository.new.user(params[:id])
        unless (user.key? "deactivated") && user["deactivated"] == "deleted"
          @user = UserModelRepository.new.create(UserModel.new(id:         user["id"],
                                                               first_name: user["first_name"],
                                                               last_name:  user["last_name"],
                                                               created_at: Time.now))
        end
      end
      @friends     = FriendModelRepository.new.friend_list(params[:id]).call
      friend_ids   = @friends.map { |friend| friend.friend_id }.to_set
      @friends = @friends.group_by { |friend| friend.friend_id }
      @user_models = UserModelRepository.new.user_models.where(id: friend_ids.to_a).call.map do |user|
        [user.id, user]
      end.to_h
    end
  end
end
