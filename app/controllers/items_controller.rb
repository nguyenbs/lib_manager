class ItemsController < ApplicationController
	def index
		if params[:search].present?
			@books = Book.search_book(params[:search][:name], params[:search][:author], params[:search][:category])
		else
			@books = Book.all
		end
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
