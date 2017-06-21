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

end
