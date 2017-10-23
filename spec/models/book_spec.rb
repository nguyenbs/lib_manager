require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:borrow_books) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:user_ratings).dependent(:destroy) }
    it { is_expected.to have_many(:relationships) }
    it { is_expected.to have_many(:users).through(:relationships).source(:ownerable).class_name(User.name) }
    it { is_expected.to have_many(:categories).through(:relationships).source(:ownerable).class_name(Category.name) }
    it { is_expected.to have_many(:authors).through(:relationships).source(:ownerable).class_name(Author.name) }
    it { is_expected.to belong_to(:publisher) }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:publisher_year).of_type(:string) }
    it { is_expected.to have_db_column(:amount).of_type(:integer) }
    it { is_expected.to have_db_column(:weight).of_type(:string) }
    it { is_expected.to have_db_column(:language).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:string) }
    it { is_expected.to have_db_column(:rating).of_type(:integer) }
    it { is_expected.to have_db_column(:cover_image).of_type(:string) }
    it { is_expected.to have_db_column(:image).of_type(:string) }
    it { is_expected.to have_db_column(:publisher_id).of_type(:integer) }
  end

  describe 'validateion' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'creations' do
    Fabricator(:book) do
      it 'number of create association authors' do
        book.authors.create name: 'Name1'
        book.authors.create name: 'Name2'
        book.count.should eq(2)
      end

      it 'number of create association categories' do
        book.categories.create name: 'Name1'
        book.categories.create name: 'Name2'
        book.count.should eq(2)
      end

      it 'number of create association publisher' do
        book.publisher.create name: 'publisher name'
        book.count.should eq(1)
      end
    end
  end
end