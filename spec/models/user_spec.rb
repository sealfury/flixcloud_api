# frozen_string_literal: true
RSpec.describe User, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column :encrypted_password }
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :tokens }
    it { is_expected.to have_db_column :name }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_confirmation_of :password }

    context 'should  not have an invalid name' do
      names = ['user name', ' ']
      names.each do |name|
        it { is_expected.not_to allow_value(name).for(:name) }
      end
    end

    context 'should  not have an invalid email address' do
      emails = ['user name', ' @example.com', 'ddd@.d']
      emails.each do |email|
        it { is_expected.not_to allow_value(email).for(:email) }
      end
    end

    context 'should have a valid email address' do
      emails = %w[
        asdf@ds.com
        hello@example.uk
        test1234@yahoo.si
        asdf@example.eu
      ]
      emails.each do |email|
        it { is_expected.to allow_value(email).for(:email) }
      end
    end
  end
end
