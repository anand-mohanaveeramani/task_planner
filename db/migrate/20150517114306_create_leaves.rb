class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.date :leave_date
      t.belongs_to :member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
