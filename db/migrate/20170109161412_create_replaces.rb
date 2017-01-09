class CreateReplaces < ActiveRecord::Migration[5.0]
  def change
    create_table :replaces do |t|
      t.string :file, null: false
      t.string :key, null: false
      t.string :value, null: false
      t.references :environment, index: true, null: false, foreign_key: true
      t.timestamps
    end
  end
end
