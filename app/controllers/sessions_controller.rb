class SessionsController < ApplicationController
  def create 
    # raise request.env["omniauth.auth"].to_yaml
    auth = request.env["omniauth.auth"]
    # user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    user = User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to '/leads/new', :notice => "Signed in!"
    client = Databasedotcom::Client.new
    client.authenticate :token => user.token, :instance_url => user.instance_url
    client.materialize("Lead")
  end
  
  def destroy 
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
