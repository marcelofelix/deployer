class CreateVersions < ActiveRecord::Migration[5.0]
  def change
    create_table :versions do |t|
      t.string :label, null: false
      t.string :description
      t.references :project, index: true, null: false, foreign_key: true
      t.timestamps
    end
  end
end
