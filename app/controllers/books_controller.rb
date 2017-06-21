class BooksController < ApplicationController
  get '/books/new' do
    if logged_in?
      erb :'books/new'
    else
      redirect to '/login'
    end
  end

  post '/books' do
    @book = Book.new(:title => params[:title], :author => params[:author])
    if @book.save
      redirect to '/index'
    else
      redirect to '/books/new'
    end
  end

  get '/books/' do
    if logged_in?
      @book = Book.all
      erb :'books/index'
    else
      redirect to '/login'
    end
  end

  get '/books/:id' do
    if logged_in?
      @book = Book.find_by_id(params[:id])
      erb :'books/show'
    else
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
    @book = Book.find_by_id(params[:id])
    if params[:title].empty? || params[:author].empty?
      redirect to "/books/#{@book.id}/edit"
    else
      @book.update(:title => params[:title], :author => params[:author])
      redirect to "/books/#{@book.id}"
    end
  end

  delete '/books/:id/delete' do
    if logged_in?
      @book = Book.find_by_id(params[:id])
      if @book.user_id == current_user
        @book.delete
        redirect to '/books'
      else
        redirect to "/books/#{@book.id}"
      end
    else
      redirect to '/login'
    end
  end

end
