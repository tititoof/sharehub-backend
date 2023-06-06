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
require 'rails_helper'
require 'net/http'

RSpec.describe Galleries::Medium, type: :model do
  subject { FactoryBot.create(:galleries_medium) }
  
  def image_file(size: '300x300', format: 'png', background_color: nil, text_color: nil, text: nil)
    file = Tempfile.new("faker_placeholdit")
    file.binmode
    file << Net::HTTP.get(URI(Faker::Placeholdit.image(size: size, format: format, background_color: background_color, text_color: text_color, text: text)))
    file.close
  
    ::File.new(file.path)
  end

  describe 'attributs' do
    it 'is valid with valid attributes' do
      subject.file.attach(io: image_file, filename: 'test')

      expect(subject).to be_valid
    end

    it 'is not valid without album' do
      subject.album = nil

      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:album).class_name('::Galleries::Album') }
    it { should have_one_attached(:file) }
  end
end
