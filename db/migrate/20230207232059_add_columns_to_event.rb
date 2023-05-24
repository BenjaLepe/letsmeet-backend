class AddColumnsToEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :background_image, :string
    add_column :events, :producer_id, :bigint
    add_column :events, :author_id, :bigint

    add_foreign_key :events, :producers
    add_foreign_key :events, :users, column: :author_id
  end
end
