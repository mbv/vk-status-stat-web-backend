module Web::Controllers::User
  class Show
    include Web::Action

    expose :user

    def call(params)
      @user = UserModelRepository.new.find(params[:id])
    end
  end
end
