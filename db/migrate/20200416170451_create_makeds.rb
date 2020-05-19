class CreateMakeds < ActiveRecord::Migration[5.2]
  def change
    create_table :makeds do |t|
      t.references :recipe, null: false, foreign_key: true
      t.text       :text,   null: false
      t.string     :image

      t.timestamps
    end
  end
end