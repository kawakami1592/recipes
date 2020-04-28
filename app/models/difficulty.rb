class Difficulty < ActiveHash::Base
  self.data = [
    { id: 1, difficulty: '簡単'},
    { id: 2, difficulty: '手軽'},
    { id: 3, difficulty: '慣れが必要'},
    { id: 4, difficulty: '1回は練習'},
    { id: 5, difficulty: '練習必至'}
  ]
end