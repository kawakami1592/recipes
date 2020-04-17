class CreateMakeds < ActiveRecord::Migration[5.2]
  def change
    create_table :makeds do |t|
      t.references :recipe
      t.text       :text
      t.string     :image

      t.timestamps
    end
  end
end