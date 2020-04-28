class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string     :title
      t.references :user
      t.references :category
      t.text       :text
      t.string     :image
      t.text       :point
      t.references :difficulty

      t.timestamps
    end
  end
end
