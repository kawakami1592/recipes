foodstuff_array = ['肉','魚','野菜','米','メン','パン','その他']
dish_array = ['主食','メイン','サイド','スープ','デザート','その他']
cooking_method_array = ['焼き物','ゆでる','炒め物','揚げ物','煮物','和え物','蒸し物','その他']

foodstuff_array.each do |foodstuff|
  parent = Category.create(name: foodstuff)
  dish_array.each do |dish|
    child = parent.children.create(name: dish)
    cooking_method_array.each do |cooking_method|
      child.children.create(name: cooking_method)
    end
  end
end


User.create!(
  nickname: 'まーたろー',
  email: 'hoge@hoge',
  password: '1111111',
  password_confirmation: '1111111',
  sex_id:'1'
)

User.create!(
  nickname: 'あやや',
  email: 'fuga@fuga',
  password: '2222222',
  password_confirmation: '2222222',
  sex_id:'2'
)