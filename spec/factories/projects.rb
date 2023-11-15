# == Schema Information
#
# Table name: projects
#
#  id                  :uuid             not null, primary key
#  category            :string
#  description         :text
#  end_at              :date
#  external_references :string
#  start_at            :date
#  status              :string
#  title               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  manager_id          :uuid             not null
#  organization_id     :uuid             not null
#
# Indexes
#
#  index_projects_on_manager_id                 (manager_id)
#  index_projects_on_organization_id            (organization_id)
#  index_projects_on_organization_id_and_title  (organization_id,title) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (manager_id => users.id)
#  fk_rails_...  (organization_id => organizations.id)
#
FactoryBot.define do
  factory :project do
    title { Faker::Commerce.product_name }
    description { Faker::Books::Lovecraft.paragraph }
    start_at { Faker::Date.between(from: '2014-09-23', to: '2014-09-25') }
    end_at { Faker::Date.between(from: '2014-10-23', to: '2014-10-25') }
    status { 'planning' }
    manager { FactoryBot.create(:user) }
    external_references { "MyString" }
    category { 'software_development' }
    organization { FactoryBot.create(:organization) }
  end
end
