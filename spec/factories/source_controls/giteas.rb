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
FactoryBot.define do
  factory :source_controls_gitea, class: 'SourceControls::Gitea' do
    api_url { Faker::Internet.url }
    access_token { Faker::Internet.uuid }
    ip_address { Faker::Internet.ip_v4_address }
    port { Faker::Number.number(digits: 4) }
  end
end
