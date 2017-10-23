require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:relationships) }
    it { is_expected.to have_many(:books).through(:relationships).source(:targetable).class_name(Book.name) }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  describe 'validateion' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'creations' do
    Fabricator(:category) do
      it 'number of create association authors' do
        category.books.create name: 'Name1'
        category.books.create name: 'Name2'
        category.books.count.should eq(2)
      end
    end
  end
end