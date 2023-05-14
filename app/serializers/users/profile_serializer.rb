# frozen_string_literal: true

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
module Users
  # Returns the JSON Profile object.
  #
  # set_key_transform :camel_lower - "some_key" => "someKey"
  class ProfileSerializer
    include JSONAPI::Serializer

    set_key_transform :camel_lower

    attributes :id, :address, :date_of_birth, :email, :first_name, :last_name, :nickname, :phone,
               :city_id, :user_id
  end
end
