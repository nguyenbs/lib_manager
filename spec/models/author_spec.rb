require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:publisher) }
    it { is_expected.to have_many(:active_relationships).class_name(Relationship.name).dependent(:destroy) }
    it { is_expected.to have_many(:books).through(:active_relationships).source(:targetable).class_name(Book.name) }
    it { is_expected.to have_many(:passive_relationships).class_name(Relationship.name).with_foreign_key('targetable_id').dependent(:destroy)}
    it { is_expected.to have_many(:follower_users).through(:passive_relationships).source(:ownerable).class_name(User.name) }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:gender).of_type(:string) }
    it { is_expected.to have_db_column(:address).of_type(:string) }
    it { is_expected.to have_db_column(:dob).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:string) }
    it { is_expected.to have_db_column(:avatar).of_type(:string) }
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'creations' do
    Fabricator(:authors) do
      it 'number of create association books' do
        author.books.create name: 'Name1'
        author.books.create name: 'Name2'
        author.books.count.should eq(2)
      end
    end
  end
end