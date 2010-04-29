module Hipchat

  class Base
    include HTTParty
    base_uri 'api.hipchat.com/v1'

    attr_accessor :auth_token

    def initialize(auth_token)
      self.auth_token = auth_token
    end

    def rooms
      rooms_json = self.class.get("/rooms/list", :query => {:auth_token => @auth_token})
      Room.instantiate_rooms(auth_token, rooms_json)
    end

    def users
      users_json = self.class.get("/users/list", :query => {:auth_token => @auth_token})
      User.instantiate_users(auth_token, users_json)
    end

  end

end