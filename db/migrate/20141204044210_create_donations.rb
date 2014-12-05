class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :username
      t.string :amount
      t.datetime :timeadded
      t.text :comment

      t.timestamps
    end
  end
end
