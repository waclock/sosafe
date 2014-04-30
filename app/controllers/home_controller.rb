class HomeController < ApplicationController
  def index
  end
  def register
  	name=params[:name]
  	email=params[:email]
  	if name!="" && email!=""
  		u=User.new
  		u.first_name=name
  		u.email=email
  		u.save
  	end
  	render :nothing => true 
  end
end
