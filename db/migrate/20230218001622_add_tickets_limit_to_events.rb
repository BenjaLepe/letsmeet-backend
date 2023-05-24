class AddTicketsLimitToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :tickets_limit, :integer, default: 0
  end
end
