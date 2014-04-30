class SessionsController < ApplicationController
  def new
    if current_user
      return redirect_to home_path, :notice => "Already logged in!"
    end
    @user = User.new
  end
    
  def create
  	user = User.authenticate(params[:email], params[:password])
    if user&&user.active==true&&!user.deleted
      
      session[:user_id] = user.id

      if session[:last_uri]
        uri = session[:last_uri]
        session[:last_uri] = nil
        return redirect_to uri, :notice => "You are now logged in!"
      end
      return redirect_to request.referer, :notice => "You are now logged in!"
    else
      if user && user.active!=true
        str = "Check your email and activate your account"
      elsif user && user.deleted!=false
        str = "This account doesn't exist"
      else
        str = "Invalid email or password"
      end
      return redirect_to log_in_path, notice: str
    end
  end
  
  def destroy
    session[:user_id] = nil
    return redirect_to home_path
  end

  def unsubscribe
    @token = Token.find_by_value(params[:token])
    unless @token
      return redirect_to home_path
    end
    @user = @token.user
    Blacklist.create(:email_to => @user.email, :email_from => params[:from], :global => (params[:from] ? false : true))
    @token.destroy
    redirect_to home_path, notice: t('notice.user.unsubscribe')
  end

end



