dish_array = ['主食','メイン','サイド','スープ','デザート','その他']
foodstuff_array = [
                    ['米','メン','パン','その他'],
                    ['肉','魚','野菜','その他'],
                    ['肉','魚','野菜','その他'],
                    ['肉','魚','野菜','その他'],
                    ['和菓子','洋菓子','その他'],
                    ['肉','魚','野菜','その他']
                  ]
cooking_method_array = ['焼き物','ゆでる','炒め物','揚げ物','煮物','和え物','蒸し物','その他']


dish_array.each_with_index do |child, i|
  child = parent.children.create(name: child)
  foodstuff_array[i].each do |grandchild|
    child.children.create(name: grandchild)
  end
end



# country_array.each do |country|
#   parent = Category.create(name: country)
#   dish_array.each_with_index do |child, i|
#     child = parent.children.create(name: child)
#     foodstuff_array[i].each do |grandchild|
#       child.children.create(name: grandchild)
#     end
#   end
# end


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