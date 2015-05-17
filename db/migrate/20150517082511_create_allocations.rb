class CreateAllocations < ActiveRecord::Migration
  def change
    create_table :allocations do |t|
      t.belongs_to :member, index: true, foreign_key: true
      t.belongs_to :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
