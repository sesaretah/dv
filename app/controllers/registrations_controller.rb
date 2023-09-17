class RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!, :except => [:new, :update, :create]

  require 'open-uri'


  def new
    super
  end

  def create
    #@username = params[:user][:mobile]
    if params[:sso].blank?
      @user = User.new(email: params[:user][:email], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
    else
      @sso = Sso.where(uuid: params[:sso]).first
      if !@sso.blank?
        if params[:user][:password].blank?
          @password = SecureRandom.hex(10)
          @password_confirmation = @password
        else
          @password = params[:user][:password]
          @password_confirmation = params[:user][:password_confirmation]
        end
        @user = User.new(email: params[:user][:email], utid: @sso.utid, password: @password , password_confirmation: @password_confirmation)
      end
    end
    respond_to do |format|
      if @user.save
        @profile = Profile.create(name: params[:user][:name], surename: params[:user][:surename], user_id: @user.id)
        sign_in(@user)
        assign_start_role(@user)
        format.html { redirect_to after_sign_in_path_for(@user), notice: 'Welcome' }
      else
        if params[:sso].blank?
          format.html { render :new }
        else
          format.html { render :new, sso: params[:sso] }
        end
      end
    end
  end

  def update
    super
  end

  def oa 
    base64 = Base64.encode64("divanSSO-Bmmkf2wpdOMDqY_GFq_ol5e9gGkMpr7q30.apigateway.ut.ac.ir:R7lMRYsJWyStd-XBXiyjvWUSVteQsO-fMc0eiiyA6Qc").gsub(/\n/, '')
    body = { 
      "grant_type" => "authorization_code",
      "code" => params[:code],
      "redirect_uri" => "https://divan.ut.ac.ir/users/oa"
    }

    headers = { 
      "Content-Type" => "application/x-www-form-urlencoded",
      "Authorization" => "Basic #{base64}"
    }

    res = HTTParty.post(
            "https://sso188-apigateway.ut.ac.ir/ApiContainer.SSO.RCL1/connect/token", 
            :body => body,
            :headers => headers
          ) 
    token = res["access_token"]
    headers = { 
      "Authorization" => "Bearer #{token}"
    }


    res = HTTParty.get(
            "https://sso188-apigateway.ut.ac.ir/ApiContainer.SSO.RCL1/connect/userinfo", 
            :query => {},
            :headers => headers
          ) 
    utid = res['UtId']
    uid = res['Uid']
    user = User.where(utid: [utid, uid]).first
    if !user.blank?
      sign_in(user)
      redirect_to after_sign_in_path_for(user)
    end
  end

  def service
    response = open('https://sso.ut.ac.ir:8443/cas/p3/serviceValidate?service=https%3A%2F%2Fdivan.ut.ac.ir%2Fusers%2Fservice&ticket='+params[:ticket], {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}).read
    @result = Hash.from_xml(response.gsub("\n", ""))
    if !@result['serviceResponse']['authenticationSuccess'].blank?
      @utid = @result['serviceResponse']['authenticationSuccess']['user']
      @new_utid = @result['serviceResponse']['authenticationSuccess']['attributes']['utid'] rescue nil
      email = @result['serviceResponse']['authenticationSuccess']['attributes']['mail'] rescue nil
      Rails.logger.info @result['serviceResponse'] rescue nil
      @sso = Sso.where(utid: [@utid, @new_utid]).first
      if @sso.blank?
        @sso = Sso.create(utid: @new_utid, uuid: SecureRandom.uuid)
      end
      @sso.status = 'success'
      @sso.save
      @user = User.where(utid: [@utid, @new_utid]).first
      @user = User.where(email: email).first if @user.blank?
      
      if !@user.blank?
        sign_in(@user)
        redirect_to after_sign_in_path_for(@user)
      else
        email = @result['serviceResponse']['authenticationSuccess']['attributes']['mail']
        password = SecureRandom.hex(10)
        Rails.logger.info @result['serviceResponse']['authenticationSuccess']['attributes']['givenName'] rescue nil
        Rails.logger.info @result['serviceResponse']['authenticationSuccess']['attributes']['sn'] rescue nil
        name = @result['serviceResponse']['authenticationSuccess']['attributes']['givenName'].to_a.first
        surename = @result['serviceResponse']['authenticationSuccess']['attributes']['sn'].to_a.first
        email = "#{@new_utid}@ut.ac.ir" if email.blank? || email == ''  || !email.is_a?(String) || email.to_s.include?('[')
        user = User.create(email: email, password: password, password_confirmation: password, utid: @new_utid)
        Rails.logger.info @new_utid rescue nil
        Rails.logger.info user.id rescue nil
        if !user.blank?
          profile = Profile.create(name: name, surename: surename, user_id: user.id)
          sleep(8)
          sign_in(user)
          redirect_to after_sign_in_path_for(user)
        end
      end
    end
  end

end
