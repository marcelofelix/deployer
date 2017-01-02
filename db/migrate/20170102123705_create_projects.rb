class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :bucket, null: false
      t.timestamps
      t.index :name, unique: true
      t.index :bucket, unique: true
    end
  end
end
