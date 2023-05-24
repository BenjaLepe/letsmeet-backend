class CreateProducers < ActiveRecord::Migration[7.0]
  def change
    create_table :producers do |t|
      t.string :email
      t.string :rut
      t.string :name

      t.timestamps
    end
  end
end
