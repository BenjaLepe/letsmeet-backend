class AddColumnToProducer < ActiveRecord::Migration[7.0]
  def change
    add_column :producers, :address, :string
    add_column :producers, :phone, :string
    add_column :producers, :website, :string
    add_column :producers, :description, :text
    add_column :producers, :image, :string
    add_column :producers, :validated, :boolean, default: false
    add_column :events, :state, :int, default: 0
  end
end
