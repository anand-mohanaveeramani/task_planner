class CreateQuarters < ActiveRecord::Migration
  def change
    create_table :quarters do |t|
      t.integer :year
      t.integer :index

      t.timestamps null: false
    end
  end
end
