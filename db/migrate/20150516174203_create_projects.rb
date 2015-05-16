class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :details
      t.belongs_to :quarter, index: true, foreign_key: true
      t.integer :points
      t.integer :priority
      t.integer :completion

      t.timestamps null: false
    end
  end
end
