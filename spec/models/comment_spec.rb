require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:book_id).of_type(:integer) }
    it { is_expected.to have_db_column(:content).of_type(:string) }
  end

  describe 'validateion' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:book) }
  end
end