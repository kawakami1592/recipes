class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|

      t.references :user, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps

      t.index [:user_id, :recipe_id], unique: true
      # 複合キーインデックス
    end
  end
end
