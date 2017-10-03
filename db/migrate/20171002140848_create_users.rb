class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :bio
      t.integer :EXP, :default => 0
      t.string :favorite_food

      t.timestamps
    end
  end
end
