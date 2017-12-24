class CartsController < ApplicationController
  before_action :authenticate_user, only: [:borrow_item, :update_process]

  def index
    if current_user.present? && current_user.admin?
      @books = BorrowBook.where.not(status: [2, 3])
    end
  end

  def borrow_item
    return if params[:item_ids].blank?
    data = BookServices::CreateBorrowBooks.new(user: current_user, book_ids: params[:item_ids], date_return: params[:date_return]).perform
    render json: {status: 200}
  end

  def update_process
    return if params[:item_ids].blank?
    data = BookServices::UpdateStatusBooks.new(user: current_user, book_ids: params[:item_ids], status: params[:status]).perform
    render json: {status: 200}
  end

  private
  def authenticate_user
    if current_user.blank?
      redirect_to new_user_session_path
    end
  end
end
