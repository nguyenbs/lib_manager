require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:borrow_books) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:user_ratings).dependent(:destroy) }
    it { is_expected.to have_many(:relationships) }
    it { is_expected.to have_many(:books).through(:relationships).class_name(:targetable).class_name(Book.name) }
    it { is_expected.to have_many(:following_author).through(:relationships).class_name(Author.name).source(:targetable) }
    it { is_expected.to have_many(:active_relationships).with_foreign_key(:ownerable_id).dependent(:destroy) }
    it { is_expected.to have_many(:following).through(:active_relationships).class_name(User.name).source(:targetable) }
    it { is_expected.to have_many(:passive_relationships).class_name(Relationship.name).with_foreign_key(:targetable_id).dependent(:destroy) }
    it { is_expected.to have_many(:followers).through(:passive_relationships).class_name(User.name).source(:ownerable) }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:password).of_type(:string) }
    it { is_expected.to have_db_column(:address).of_type(:string) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:phone_number).of_type(:string) }
    it { is_expected.to have_db_column(:gender).of_type(:string) }
    it { is_expected.to have_db_column(:avatar).of_type(:string) }
    it { is_expected.to have_db_column(:dob).of_type(:string) }
  end

  describe 'validateion' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }
  end
end