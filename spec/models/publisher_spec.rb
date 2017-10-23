require 'rails_helper'

RSpec.describe Publisher, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:authors) }
    it { is_expected.to have_many(:books) }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:address).of_type(:string) }
    it { is_expected.to have_db_column(:phone).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:string) }
    it { is_expected.to have_db_column(:image).of_type(:string) }
  end

  describe 'validateion' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'creations' do
    Fabricator(:publisher) do
      it 'number of create association books' do
        publisher.books.create name: 'Name1'
        publisher.books.create name: 'Name2'
        category.books.count.should eq(2)
      end

      it 'number of create association authors' do
        publisher.authors.create name: 'Name1'
        publisher.authors.create name: 'Name2'
        category.authors.count.should eq(2)
      end
    end
  end
end