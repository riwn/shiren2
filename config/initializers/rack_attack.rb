class Rack::Attack
    throttle('req/ip', :limit => 300, :period => 3.minutes) do |req|
        req.ip # unless req.path.start_with?('/assets')
      end

      # 例: 同一IPアドレスからの/loginsへのPOSTリクエストを5分あたり5回までに制限
      throttle('login/ip', :limit => 5, :period => 5.minutes) do |req|
        if req.path == '/users/sign_in' && req.post?
          req.ip
        end
      end

      # 例: 同一IPアドレスからの/loginsへのPOSTリクエストを20秒あたり5回までに制限
      throttle('/ranking/newrecord', :limit => 10, :period => 10.minutes) do |req|
        if req.path == '/ranking/newrecord' && req.post?
          req.ip
        end
      end

      throttle('/users', :limit => 5, :period => 300.minutes) do |req|
        if req.path == '/users' && req.post?
          req.ip
        end
      end

      throttle('/opinion', :limit => 10, :period => 60.minutes) do |req|
        if req.path == '/opinion' && req.post?
          req.ip
        end
      end
      Rack::Attack.throttled_response = lambda do |env|
        [ 503, {}, [File.read(Rails.public_path.join('503.html'))]]
      end
  end