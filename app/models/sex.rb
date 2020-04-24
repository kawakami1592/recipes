class Sex < ActiveHash::Base
  self.data = [
    { id: 1, sex: '男' },
    { id: 2, sex: '女' },
    { id: 3, sex: '中性' }
  ]
end