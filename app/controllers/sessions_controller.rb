class SessionsController < ApplicationController
  def create 
    raise request.env["omniauth.auth"].to_yaml
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
    begin
      client.materialize(nil)
    rescue
    end
    redirect_to root_url, :notice => "Signed out!"
  end
end


# client = Databasedotcom::Client.new :client_id => "3MVG9y6x0357HledZQgj1XEr5IilzYK68ewOkmN9bgVxZtyMlDY8_QqVB_Fg9GqK7.SQjoXD5fsBqF49nDHLR", :client_secret => "3725793166232094938", :user_id => "005E0000000GmckIAC", :sobject_module => "Module"
# client.authenticate :token => "00DE0000000aHNC!AQIAQPKeQ8Euq06X8W02jf5WbhzCKgp0D.to8D5HEWebOzi9jxnTCcsx00rVWAduE7_EuXmGhgebRxHJwX.OLKNcVBWKEtSt", :instance_url => "https://na9.salesforce.com", :refresh_token => "5Aep861rEpScxnNE64..BjXbfMFaOoZVy8dErI3z9N4SxAtcTns4NPlM46qnrvFlGbbcJJjichuBw=="

# client = Databasedotcom::Client.new :client_id => "3MVG9y6x0357HledZQgj1XEr5IilzYK68ewOkmN9bgVxZtyMlDY8_QqVB_Fg9GqK7.SQjoXD5fsBqF49nDHLR", :client_secret => "3725793166232094938", :user_id => "005E0000000epp7IAA", :sobject_module => "Module"
# client.authenticate :token => "00DE0000000ZfeY!AQwAQDHh72orVdH_vVwqGq7t6eYr3TcPjms3boUzpTRJy1mAFKoZxD31n19QUMAVhc_TEYtNG5qzL1wwcax3a95p9pr0wi_c", :instance_url => "https://na9.salesforce.com", :refresh_token => "5Aep861rEpScxnNE66Rv3QieBZJ8TZrgI70w4cSOl2rhcUsmXpZCk3mFcE6DbXzt99Mmb4aL8Of5g=="

