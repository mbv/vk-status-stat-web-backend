module Web::Views::Home
  class Index
    include Web::View


    def friends
      if current_user
        result = UserRepository.new.friends(current_user)
        result
      else
        []
      end
    end
  end
end
