module Web::Views::Home
  class Index
    include Web::View


    def friends
      if current_user
        VKRepository.new.friends(current_user)
      else
        []
      end
    end
  end
end
