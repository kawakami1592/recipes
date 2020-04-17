class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :recipe
      t.string     :product
      t.string     :quantity

      t.timestamps
    end
  end
end
