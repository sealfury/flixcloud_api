# frozen_string_literal: true

RSpec.describe Movie, type: :model do

  describe '\'Movies\' has db columns' do
    it { is_expected.to have_db_column :title }
  end

    describe 'Validations' do
      it { is_expected.to validate_presence_of :title }
    end

    describe 'Factory' do
      it 'is expected to have a valid Factory' do
        expect(create(:movie)).to be_valid
    end
  end
end