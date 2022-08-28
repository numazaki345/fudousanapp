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

20.times do |n|
  Building.create!(
    # n + 1で数字が重複しないようにする
    name: "テスト物件#{n + 1}",
    zipcode: "1060032",
    prefectures: "東京都",
    city: "港区",
    town_name: "六本木3丁目2-1",
    station: "六本木一丁目駅",
    station_minute: "#{n + 1}",
    completion: "#{n + 1}",
    floor_height: "#{n + 1}",
    building_type: "マンション",
    balcony_type: "北",
    structure_type: "鉄筋コンクリート",
    user_id: User.first.id
  )
end

20.times do |n|
  Room.create!(
    # n + 1で数字が重複しないようにする
    rent: "#{n * 10000}",
    square: "#{n + 1}",
    room_number: "#{n + 1}",
    madori: "1K",
    floor: "#{n + 1}",
    building_id: n + 1
  )
end

20.times do |n|
  Client.create!(
   # n + 1で数字が重複しないようにする
   name: "テストユーザー#{n + 1}",
   email: "test@user#{n + 1}.com",
 )
end

20.times do |n|
  Condition.create!(
    # n + 1で数字が重複しないようにする
    area: '東京都港区',
    rent_high: '下限なし',
    rent_low: '上限なし',
    rent_option: '管理費・共益費込み',
    minute: '10分以内',
    madori: '1K',
    building: 'マンション',
    completion: '10年以内',
    row: 'エアコン付き',
    client_id: n + 1
  )
end
