class PageController < ApplicationController
  def index
    @books = Book.all.limit(8)
  end

  def search
    @books = Book.search_book(params[:search][:name], params[:search][:author], params[:search][:category])
    binding.pry
		if @books
      redirect_to items_path(@books)
    else
      flash[:danger] = 'Book not exist'
      redirect_to root_path
    end
  end
end
