# frozen_string_literal: true

# The ProjectCategoryOptions enums
module ProjectCategoryOptions
  extend ActiveSupport::Concern

  included do
    enum project_category_options: {
      software_development: :software_development, # Développement logiciel
      design_and_creativity: :design_and_creativity, # Design et créativité
      marketing_and_advertising: :marketing_and_advertising, # Marketing et publicité
      project_management: :project_management, # Gestion de projet
      human_resources: :human_resources, # Ressources humaines
      finance_and_accounting: :finance_and_accounting, # Finance et comptabilité
      sales_and_business: :sales_and_business, # Vente et commerce
      research_and_development: :research_and_development, # Recherche et développement
      infrastructure_and_technology: :infrastructure_and_technology, # Infrastructure et technologies
      customer_support: :customer_support # Support client
    }
  end
end
