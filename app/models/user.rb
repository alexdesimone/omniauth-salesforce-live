class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :email, :location, :phone, :owner_id, :token, :refresh_token, :instance_url
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.location = auth["info"]["location"]
      user.phone = auth["info"]["phone"]
      user.owner_id = auth["extra"]["user_id"]
      user.token = auth["credentials"]["token"]
      user.refresh_token = auth["credentials"]["refresh_token"]
      user.instance_url = auth["credentials"]["instance_url"]
      # user.save
    end
  end
  
end