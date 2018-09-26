module Web::Controllers::User
  class Track
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
                                                               created_at: Time.now,
                                                               tracked:    true))
          return "created"
        end
        return "deactivated"
      end
      
      UserModelRepository.new.update(params[:id], tracked: true)
      "ok"
    end
  end
end
