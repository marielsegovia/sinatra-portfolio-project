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

end
