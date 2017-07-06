class BooksController < ApplicationController

    get '/books' do
      if logged_in?
        @user = User.find_by_id(session[:user_id])
        @books = Book.all
        erb :'books/index'
      else
        redirect to '/login'
      end
    end

  get '/books/new' do
    if logged_in?
      erb :'books/new'
    else
      redirect to '/login'
    end
  end

  post '/books' do
    if params[:title] == "" || params[:author] == ""
      redirect to '/books/new'
    else
      @book = Book.create(title: params[:title], author: params[:author], user_id: current_user.id)
      @book.save
      redirect to "/books/#{@book.id}"
    end
  end

  get '/books/:id' do
    if logged_in?
      @book = Book.find_by_id(params[:id])
      erb :'books/show'
    else
      flash[:message] = "Please login to access your library."
      redirect to '/login'
    end
  end

  get '/books/:id/edit' do
    if logged_in?
      @book = Book.find_by_id(params[:id])
      if @book.user_id == current_user.id
        erb :'books/edit'
      else
        redirect to '/books'
      end
    else
      redirect to '/login'
    end
  end

  patch '/books/:id' do
    if params[:title] == "" || params[:author] == ""
      redirect to "/books/#{params[:id]}/edit"
    else
      @book = Book.find_by_id(params[:id])
      @book.title = params[:title]
      @book.author = params[:author]
      @book.save
      redirect to "/books/#{@book.id}"
    end
  end

  delete '/books/:id/delete' do
    if logged_in?
      @book = Book.find_by_id(params[:id])
      if @book.user_id == current_user.id
         @book.delete
      else
        redirect to '/books'
      end
    else
      redirect to '/login'
    end
  end

end
