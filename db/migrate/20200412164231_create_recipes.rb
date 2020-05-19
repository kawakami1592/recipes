class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string     :title,      null: false
      t.references :user,       null: false, foreign_key: true
      t.references :category,   null: false
      t.text       :text,       null: false
      t.string     :image,      null: false
      t.text       :point
      t.references :difficulty, null: false

      t.timestamps
    end
  end
end
