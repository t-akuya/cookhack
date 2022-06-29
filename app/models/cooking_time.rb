class CookingTime < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '5分以内' },
    { id: 3, name: '10分以内' },
    { id: 4, name: '15分以内' },
    { id: 5, name: '20分以内' },
    { id: 6, name: '30分以内' },
    { id: 7, name: '40分以内' },
    { id: 8, name: '50分以内' },
    { id: 9, name: '60分以内' },
    { id: 10, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :repertoires
end
