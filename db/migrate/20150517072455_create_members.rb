class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.decimal :deliver_rate, precision: 10, scale: 3

      t.timestamps null: false
    end
  end
end
