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
require 'rails_helper'

RSpec.describe Galleries::Album, type: :model do
  describe "Group" do
    subject { FactoryBot.create(:galleries_album_group) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without description' do
      subject.description = nil
  
      expect(subject).not_to be_valid
    end
  
    it 'is not valid with aasm_state' do
      subject.aasm_state = "wrong enum"
  
      expect(subject).not_to be_valid
    end
  
    it 'is not valid without title' do
      subject.title = nil
  
      expect(subject).not_to be_valid
    end
  end

  describe "Organization" do
    subject { FactoryBot.create(:galleries_album_organization) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without description' do
      subject.description = nil
  
      expect(subject).not_to be_valid
    end
  
    it 'is not valid with aasm_state' do
      subject.aasm_state = "wrong enum"
  
      expect(subject).not_to be_valid
    end
  
    it 'is not valid without title' do
      subject.title = nil
  
      expect(subject).not_to be_valid
    end
  end

  describe "User" do
    subject { FactoryBot.create(:galleries_album) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without description' do
      subject.description = nil
  
      expect(subject).not_to be_valid
    end
  
    it 'is not valid with aasm_state' do
      subject.aasm_state = "wrong enum"
  
      expect(subject).not_to be_valid
    end
  
    it 'is not valid without title' do
      subject.title = nil
  
      expect(subject).not_to be_valid
    end
  end
end
