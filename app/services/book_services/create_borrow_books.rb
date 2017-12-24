class BookServices::CreateBorrowBooks
  def initialize args = {}
    @current_user = args[:user]
    @book_ids = args[:book_ids]
    @date_return = args[:date_return]
  end

  def perform
    User.transaction do
      @book_ids.each do |book_id|
        @current_user.borrow_books.create! book_id: book_id, date_return: @date_return, date_borrow: Date.today
      end
    end
  rescue
    false
  end
end
