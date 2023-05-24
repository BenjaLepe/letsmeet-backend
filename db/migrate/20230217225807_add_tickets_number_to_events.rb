class AddTicketsNumberToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :tickets_number, :integer, default: 0
  end
end
