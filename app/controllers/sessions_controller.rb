class SessionsController < ApplicationController
  def create 
    # raise request.env["omniauth.auth"].to_yaml
    auth = request.env["omniauth.auth"]
    # user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    user = User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to '/leads/new', :notice => "Signed in!"
    client = Databasedotcom::Client.new :client_id => "3MVG9y6x0357HledZQgj1XEr5IilzYK68ewOkmN9bgVxZtyMlDY8_QqVB_Fg9GqK7.SQjoXD5fsBqF49nDHLR", :client_secret => "3725793166232094938", :user_id => user.owner_id
    client.authenticate :token => user.token, :instance_url => user.instance_url, :refresh_token => user.refresh_token
    client.materialize("Lead")
  end
  
  def destroy
    auth = nil
    user = nil
    client = nil 
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end


# client = Databasedotcom::Client.new :client_id => "3MVG9y6x0357HledZQgj1XEr5IilzYK68ewOkmN9bgVxZtyMlDY8_QqVB_Fg9GqK7.SQjoXD5fsBqF49nDHLR", :client_secret => "3725793166232094938", :user_id => "005E0000000epp7IAA"
# client.authenticate :token => "00DE0000000ZfeY!AQwAQA_8ttEavjfejJxKDzC5UGWFQrV0NXXPysRAONeZUH_wBtijVePXseieqSQQ5eNzS6FbSESUC8GQln7avuOsq7a3ourF", :instance_url => "https://na9.salesforce.com", :refresh_token => "5Aep861rEpScxnNE66Rv3QieBZJ8TZrgI70w4cSOl2rhcUsmXqDGdthH98V3ff4aCek4TBRmYMJPQ=="

