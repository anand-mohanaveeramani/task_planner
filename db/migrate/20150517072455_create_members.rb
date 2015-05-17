class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.decimal :deliver_rate

      t.timestamps null: false
    end
  end
end
