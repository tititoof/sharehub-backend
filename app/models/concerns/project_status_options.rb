# frozen_string_literal: true

# The ProjectStatusOptions enums
module ProjectStatusOptions
  extend ActiveSupport::Concern

  included do
    attribute :status, :string
    enum :status, {
      planning: 'planning', # Planification
      in_progress: 'in_progress', # En cours
      on_hold: 'on_hold', # En attente
      completed: 'completed', # Terminé
      cancelled: 'cancelled', # Annulé
      pending_approval: 'pending_approval', # En attente d'approbation
      archived: 'archived' # Archivé
    }, validate: true
  end
end
