require 'rails_helper'

RSpec.describe BorrowBook, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:date_borrow).of_type(:date) }
    it { is_expected.to have_db_column(:date_return).of_type(:date) }
    it { is_expected.to have_db_column(:status).of_type(:integer) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:book_id).of_type(:integer) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:book) }
    it { is_expected.to validate_presence_of(:date_borrow) }
  end
end
