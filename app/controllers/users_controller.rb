class UsersController < ApplicationController

  get '/' do
    erb :'index'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if logged_in?
      redirect to '/books'
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      @user.save
      session[:user_id] = @user.id
      redirect to '/books'
    end
  end

end
