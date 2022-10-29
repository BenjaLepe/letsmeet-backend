class AddNewFieldsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string, limit: 50
    add_column :users, :last_name, :string, limit: 50
    add_column :users, :dni, :string, limit: 30
    add_column :users, :date_of_birth, :datetime
    add_column :users, :phone, :string, limit: 14
    add_column :events, :start_date, :datetime
    add_column :events, :end_date, :datetime

    add_index :users, :dni, unique: true
  end
end
