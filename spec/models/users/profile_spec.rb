# == Schema Information
#
# Table name: users_profiles
#
#  id            :uuid             not null, primary key
#  address       :string
#  date_of_birth :date
#  email         :string
#  first_name    :string
#  last_name     :string
#  nickname      :string
#  phone         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  city_id       :uuid
#  user_id       :uuid             not null
#
# Indexes
#
#  index_users_profiles_on_city_id   (city_id)
#  index_users_profiles_on_nickname  (nickname) UNIQUE
#  index_users_profiles_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => location_cities.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Users::Profile, type: :model do
  subject { FactoryBot.create(:users_profile) }

  describe 'attributs' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid with wrong age' do
      subject.date_of_birth = Faker::Date.in_date_period

      expect(subject).not_to be_valid
    end

    it 'is not valid without first_name' do
      subject.first_name = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without last_name' do
      subject.last_name = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without nickname' do
      subject.nickname = nil

      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:city).class_name('::Location::City') }
    it { should belong_to(:user).class_name('::User') }
  end
end
