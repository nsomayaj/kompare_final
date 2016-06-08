class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :city
      t.string :url
      t.string :name
      t.string :cuisine
      t.float :cost
      t.float :rating
      t.float :votes

      t.timestamps null: false
    end
  end
end
