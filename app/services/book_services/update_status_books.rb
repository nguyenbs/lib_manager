class BookServices::UpdateStatusBooks
  def initialize args = {}
    @current_user = args[:user]
    @book_ids = args[:book_ids]
    @status = args[:status].to_i
  end

  def perform
    User.transaction do
      @book_ids.each do |book_id|
        relation = BorrowBook.find_by(id: book_id)
        amount = relation.book.amount
        break if relation.book.amount == 0
        if @status ==1
          relation.book.update_attributes amount:amount - 1
        elsif @status == 2
          relation.book.update_attributes amount:amount + 1
        end
        BorrowBook.find_by(id: book_id).update_attributes(status: @status)
      end
    end
  rescue
    false
  end
end
