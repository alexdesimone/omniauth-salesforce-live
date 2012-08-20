class LeadsController < ApplicationController
  # include Databasedotcom::Rails::Controller
  #
  # auth = request.env["omniauth.auth"]
  # user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
  # client.authenticate :token => user.oauth_token, :instance_url => user.instance_url
  # def authenticate
  #   auth = request.env["omniauth.auth"]
  #   user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
  #   client = Databasedotcom::Client.new
  #   client.authenticate :token => user.token, :instance_url => user.instance_url
  #   client.materialize("Lead")
  # end  
    
  def new
    @lead = Lead.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lead }
    end
  end
  
  def create
    @lead = Lead.new(params[:lead])
    # @lead['OwnerId'] = User.find(session[:user_id]).owner_id
    @lead['OwnerId'] = User.last.owner_id
    @lead['IsConverted'] = false
    @lead['IsUnreadByOwner'] = true
    respond_to do |format|
      if @lead.save
        format.html { redirect_to 'leads/new' }
        format.json { render json: @lead, status: :created, location: @lead }
        flash[:success] = "Salesforce lead was successfully created!"
      else
        format.html { render action: "new" }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end
end
