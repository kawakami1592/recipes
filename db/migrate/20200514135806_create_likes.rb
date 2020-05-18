class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|

      t.references :user, null: false
      t.references :recipe, null: false

      t.timestamps

      t.index [:user_id, :recipe_id], unique: true
      # 複合キーインデックス
    end
  end
end
