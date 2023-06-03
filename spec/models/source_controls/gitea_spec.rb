# == Schema Information
#
# Table name: source_controls_giteas
#
#  id           :uuid             not null, primary key
#  access_token :string
#  api_url      :string
#  ip_address   :string
#  port         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe SourceControls::Gitea, type: :model do
  subject { FactoryBot.create(:source_controls_gitea) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without access_token' do
    subject.access_token = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid without api_url' do
    subject.api_url = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid without ip_address' do
    subject.ip_address = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid with wrong ip_address' do
    subject.ip_address = '256.2.1.1'

    expect(subject).not_to be_valid
  end

  it 'is not valid without port' do
    subject.port = nil

    expect(subject).not_to be_valid
  end
end
