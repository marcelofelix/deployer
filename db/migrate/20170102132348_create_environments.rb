class CreateEnvironments < ActiveRecord::Migration[5.0]
  def change
    create_table :environments do |t|
      t.string :name, null: false
      t.string :version, null: false
      t.string :bucket, null: false
      t.references :project, index: true, null: false, foreign_key: true
      t.timestamps
    end
  end
end
