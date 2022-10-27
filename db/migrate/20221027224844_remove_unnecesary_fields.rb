class RemoveUnnecesaryFields < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :publisher_id
  end
end
