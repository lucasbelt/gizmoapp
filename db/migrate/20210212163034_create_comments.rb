class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :ccomments do |t|
      t.text :description
      t.integer :chef_id
      t.integer :recipe_id
      t.timestamps
    end

    create_table :comments do |t|
      t.text :description
      t.integer :user_id
      t.integer :product_id
      t.timestamps
    end
  end
end
