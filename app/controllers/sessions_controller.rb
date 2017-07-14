class SessionsController < ApplicationController
    
    #Render the form
    def new
    
    end
    
    #Get the submission of the new form
    def create
        #Search by session mail
        user = User.find_by(email: params[:session][:email].downcase)
        
        #Verifies whether the user exist and the password works for that user
        if user && user.authenticate(params[:session][:password])
            #Lets store the user id in the session hash for the requests
            session[:user_id] = user.id
            flash[:success] = "You have successfully logged in"
            redirect_to user_path(user)
        else
            #Flash.now dont persist between html pages requests
            flash.now[:danger] = "There was something wrong with your login information"
            render 'new'
        end
    end
    
    #Destroy the session
    def destroy
        session[:user_id] = nil
        flash[:success] = "You have logged out"
        redirect_to root_path
    end
    
end