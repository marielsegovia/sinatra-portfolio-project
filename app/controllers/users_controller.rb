class UsersController < ApplicationController

  get '/' do
    erb :'index'
  end

  get '/users/:slug' do
      if logged_in?
        @user = User.find_by_id(session[:user_id])
        erb :'users/show'
      else
        redirect to '/login'
      end
  end

  get '/signup' do
    if !logged_in?
      erb :'users/new'
    else
      redirect to '/books'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/books'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      flash[:message] = "Please fill the form completely."
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/books'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/users/#{@user.slug}"
    else
      flash[:message] = "Try again."
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
