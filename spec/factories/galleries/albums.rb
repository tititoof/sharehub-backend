# == Schema Information
#
# Table name: galleries_albums
#
#  id             :uuid             not null, primary key
#  aasm_state     :string
#  albumable_type :string           not null
#  description    :text
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  albumable_id   :uuid             not null
#
# Indexes
#
#  index_galleries_albums_on_albumable  (albumable_type,albumable_id)
#
FactoryBot.define do
  factory :galleries_album, class: 'Galleries::Album' do
    albumable { FactoryBot.create(:user) }
    title { Faker::Game.title }
    description { Faker::Books::Lovecraft.paragraph }
    aasm_state { :draft }

    factory :galleries_album_group, class: 'Galleries::Album' do
      albumable { FactoryBot.create(:users_group) }
    end

    factory :galleries_album_organization, class: 'Galleries::Album' do
      albumable { FactoryBot.create(:organization) }
    end
  end
end
