module Web::Controllers::User
  class Chart
    include Web::Action

    def time_iterate(start_time, end_time, step, &block)
      start_time += 3 * 60 * 60
      end_time   += 3 * 60 * 60
      begin
        yield(start_time)
      end while (start_time += step) <= end_time
    end

    def call(params)
      self.format = :json
      onlines = OnlineModelRepository.new.for_user(params[:id])
      datas  = Array.new
      (24 * 60).times do |i|
        datas[i] = 0
      end
      first_online = false
      time_start   = 0
      onlines.each do |online|
        if first_online
          if online.status == 1
            time_start = online.changed_at
          else
            time_iterate(time_start, online.changed_at, 60) do |t|
              datas[t.hour * 60 + t.min] += 1
            end
          end
        elsif online.status == 1
          first_online = true
          time_start   = online.changed_at
        end
      end
      self.body = datas.to_json
    end
  end
end
