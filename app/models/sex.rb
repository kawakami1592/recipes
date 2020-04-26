class Sex < ActiveHash::Base
  self.data = [
    { id: 1, sex: '男性' },
    { id: 2, sex: '女性' }
  ]
end