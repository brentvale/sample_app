class SessionsController < ApplicationController
	def new
	end

	def create
		  user = User.find_by(email: params[:session][:email].downcase)
    	if user && user.authenticate(params[:session][:password])
      		sign_in user
      		redirect_to user
    	else
      		flash.now[:error] = 'Invalid email/password combination' 
      		#use flash.now instead of flash because flash.now is specifically designed 
      		#for displaying flash messages on rendered pages, flash.now's contents disappear
      		#as soon as there is an additional request
      		render 'new'
    	end
	end

	def destroy
    sign_out
    redirect_to root_url
	end

end
