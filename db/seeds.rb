# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Creating User..."
user = User.find_by(email: 'test@test.com')
if user
  puts "User already exists: #{user.email}"
else
  user = User.create!(
    email: 'test@test.com',
    password: 'test1234'
  )
  puts "Created User: #{user.email}"
end

puts "\nCreating Buildings and Addresses..."
buildings = []

# 画像ファイルのパスを取得
image_path = Rails.root.join('lib', 'building_mansion2.png')

20.times do |n|
  # Buildingを作成
  building = Building.create!(
    name: "テスト物件#{n + 1}",
    station: '六本木一丁目駅',
    station_minute: n + 1,
    completion: n + 1,
    floor_height: n + 1,
    building_type: 'マンション',
    balcony_type: '北',
    structure_type: '鉄筋コンクリート',
    user_id: user.id
  )

  # 画像を添付
  if File.exist?(image_path)
    building.image.attach(
      io: File.open(image_path),
      filename: 'building_mansion2.png',
      content_type: 'image/png'
    )
  end

  # 対応するAddressを作成
  Address.create!(
    building_id: building.id,
    zipcode: 1060032,
    prefectures: '東京都',
    city: '港区',
    town_name: '六本木3丁目2-1'
  )
  
  buildings << building
  puts "Created Building #{n + 1}: #{building.name} (with image)"
end

puts "\nCreating Rooms..."
buildings.each_with_index do |building, index|
  Room.create!(
    rent: index * 10_000,
    square: index + 1,
    room_number: "#{index + 1}01",
    madori: '1K',
    floor: index + 1,
    building_id: building.id
  )
  puts "Created Room for Building #{index + 1}: Rent #{index * 10_000}円"
end

puts "\nCreating Clients..."
clients = []
20.times do |n|
  client = Client.create!(
    name: "テストユーザー#{n + 1}",
    email: "test@user#{n + 1}.com"
  )
  clients << client
  puts "Created Client #{n + 1}: #{client.name}"
end

puts "\nCreating Conditions..."
clients.each_with_index do |client, index|
  Condition.create!(
    area: '東京都港区',
    rent_high: '下限なし',
    rent_low: '上限なし',
    rent_option: '管理費・共益費込み',
    minute: '10分以内',
    madori: '1K',
    building: 'マンション',
    completion: '10年以内',
    row: 'エアコン付き',
    client_id: client.id
  )
  puts "Created Condition for Client #{index + 1}"
end

puts "\n✅ Seed data created successfully!"
puts "- Users: #{User.count}"
puts "- Buildings: #{Building.count}"
puts "- Addresses: #{Address.count}"
puts "- Rooms: #{Room.count}"
puts "- Clients: #{Client.count}"
puts "- Conditions: #{Condition.count}"
