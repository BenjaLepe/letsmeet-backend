class AddEventTicketsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :event_tickets do |t|
      t.string :title
      t.string :description
      t.float :price
      t.integer :quantity
      t.references :event, foreign_key: true
      t.timestamps
    end
    remove_column :events, :tickets_number
    remove_column :events, :tickets_limit
    remove_column :tickets, :dni
    remove_column :tickets, :details
    remove_column :tickets, :email
    remove_column :tickets, :full_name
  end
end
