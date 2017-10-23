require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:ownerable) }
    it { is_expected.to belong_to(:targetable) }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:ownerable_id).of_type(:integer) }
    it { is_expected.to have_db_column(:ownerable_type).of_type(:string) }
    it { is_expected.to have_db_column(:targetable_id).of_type(:integer) }
    it { is_expected.to have_db_column(:targetable_type).of_type(:string) }
  end
end