module Hipchat

  class Room < Hipchat::Base

    attr_accessor :auth_token, :room_hash

    def self.instantiate_rooms(auth_token, rooms_json)
      rooms_json['rooms'].inject([]) do |rooms, room_json|
        rooms << Room.new(auth_token, room_json)
      end
    end

    def initialize(auth_token, room_hash)
      self.auth_token = auth_token
      self.room_hash = room_hash
    end

    def method_missing(method_name)
      super unless [:name, :room_id, :topic, :last_active, :owner_user_id].include?(method_name)
      room_hash[method_name.to_s]
    end

    def users
      users_hash = self.class.get("/rooms/show", :query => {:room_id => self.room_id, :auth_token => self.auth_token})
      User.instantiate_users(auth_token, users_hash)
    end

    def speak(from_name, message)
      self.class.post("/rooms/message", :body => {:from => URI.escape(from_name), :message => URI.escape(message), :room_id => self.room_id}, :query => {:auth_token => self.auth_token})
    end

  end

end