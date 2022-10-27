class ReplaceReferenceEventToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_reference :events, :user
    remove_column :users, :publisher_id
    add_reference :events, :author, foreign_key: { to_table: :users }
  end
end
