module Hipchat

  class User < Hipchat::Base

    attr_accessor :auth_token, :user_hash

    def self.instantiate_users(auth_token, users_json)
      users_json = users_json.keys.include?("users") ? users_json["users"] : users_json['room']['participants']
      users_json.inject([]) do |users, user_json|
        users << User.new(auth_token, user_json)
      end
    end

    def initialize(auth_token, user_hash)
      self.auth_token = auth_token
      self.user_hash  = user_hash
    end

    def profile
      user_hash = self.class.get("/users/show", :query => {:user_id => self.user_id, :auth_token => self.auth_token})
      self.user_hash.merge!(user_hash["user"])
      self
    end

    def method_missing(method_name)
      super unless [:user_id, :name, :email, :title, :photo_url, :status, :is_group_admin].include?(method_name)
      user_hash[method_name.to_s]
    end

  end

end