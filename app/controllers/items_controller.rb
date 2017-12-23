class ItemsController < ApplicationController
	def index
		@books = Book.all
	end

	def show
	end

	def search
		@books = Book.search_book(params[:search][:name], params[:search][:author], params[:search][:category])
		respond_to do |format|
			format.html {redirect_to items_path}
			format.js
		end
	end
end
