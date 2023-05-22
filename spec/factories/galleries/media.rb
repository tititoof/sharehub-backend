# == Schema Information
#
# Table name: galleries_media
#
#  id         :uuid             not null, primary key
#  kind       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :uuid             not null
#
# Indexes
#
#  index_galleries_media_on_album_id  (album_id)
#
# Foreign Keys
#
#  fk_rails_...  (album_id => galleries_albums.id)
#
FactoryBot.define do
  factory :galleries_medium, class: 'Galleries::Medium' do
    kind { ::Galleries::Medium::kind_options.keys.sample }
    album { FactoryBot.create(:galleries_album) }
  end
end
