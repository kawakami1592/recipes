# 女性が作ってもらいたい料理 Women want you to make it
woman_want_child_array = ['手軽','豪華']
woman_want_grandchild_array = [['肉','魚','野菜','その他'],['肉','魚','野菜','その他']]

parent = Category.create(name: '作ってほしい')
woman_want_child_array.each_with_index do |child, i|
  child = parent.children.create(name: child)
  woman_want_grandchild_array[i].each do |grandchild|
    child.children.create(name: grandchild)
  end
end

# 男性が作ってあげたい料理
want_to_child_array = ['手軽','豪華']
want_to_grandchild_array = [['肉','魚','野菜','その他'],['肉','魚','野菜','その他']]

parent = Category.create(name: '作ってあげたい')
want_to_child_array.each_with_index do |child, i|
  child = parent.children.create(name: child)
  want_to_grandchild_array[i].each do |grandchild|
    child.children.create(name: grandchild)
  end
end


man = User.create!(
  nickname: 'まーたろー',
  email: 'hoge@hoge',
  password: '1111111',
  password_confirmation: '1111111',
  sex_id:'1'
)

woman = User.create!(
  nickname: 'あやや',
  email: 'fuga@fuga',
  password: '2222222',
  password_confirmation: '2222222',
  sex_id:'2'
)