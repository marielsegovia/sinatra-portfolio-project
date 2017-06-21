class UsersController < ApplicationController

  get '/' do
    erb :'index'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
