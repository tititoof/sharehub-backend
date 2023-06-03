class CreateSourceControlsGiteas < ActiveRecord::Migration[7.0]
  def change
    create_table :source_controls_giteas, id: :uuid do |t|
      t.string :api_url
      t.string :access_token
      t.string :ip_address
      t.integer :port

      t.timestamps
    end
  end
end
