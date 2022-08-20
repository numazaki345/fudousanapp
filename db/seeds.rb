# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(
  email: 'test@test.com',
  password: 'test1234',
)

100.times do |n|
  Building.create!(
    # n + 1で数字が重複しないようにする
    name: "テストユーザー#{n + 1}",
    zipcode: "1060032",
    prefectures: "東京都",
    city: "港区",
    town_name: "六本木3丁目2-1",
    transportation: "六本木一丁目駅徒歩1分",
    completion: '10',
    floor_height: "10",
    building_type: "マンション",
    balcony_type: "北",
    structure_type: "鉄筋コンクリート",
    user_id: User.first.id
  )
end
