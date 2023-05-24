class AddExtraInfoToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :dni, :string
    add_column :tickets, :full_name, :string
    add_column :tickets, :email, :string
    add_column :tickets, :qr, :string
  end
end
