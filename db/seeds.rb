# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

users = [
  { 
    name: "山田",
    handle_name: "うでながおじさん",
    password: "password",
    image: "sample-user1.jpg"
  },
  {
    name: "佐藤",
    handle_name: "微糖ママ",
    password: "password",
    image: "sample-user2.jpg"
  },
  {
    name: "河村",
    handle_name: "KaKa@z",
    password: "password",
    image: nil
  }
]

posts = [
  {
    title: "屋久島に行ってきました！",
    body: "縄文杉まで歩いてきました。",
    image: "sample-post1.jpg",
    user: user1,
    is_publish: true
  },
  {
    title: "屋久島に行ってきました！",
    body: "縄文杉まで歩いてきました。",
    image: nil,
    user: user1,
    is_publish: true
  },
  {
    title: "屋久島に行ってきました！",
    body: "縄文杉まで歩いてきました。",
    image: "sample-post2.jpg",
    user: user1,
    is_publish: false
  },
  {
    title: "北海道旅行",
    body: "ラベンダー畑が最高でした。",
    image: "sample-post3.jpg",
    user: user2,
    is_publish: false
  },
  {
    title: "北海道旅行",
    body: "ラベンダー畑が最高でした。",
    image: "sample-post4.jpg",
    user: user2,
    is_publish: false
  },
  {
    title: "北海道旅行",
    body: "ラベンダー畑が最高でした。",
    image: "sample-post5.jpg",
    user: user2,
    is_publish: true
  },
  {
    title: "沖縄の海",
    body: "透明度がすごかった！",
    image: "sample-post6.jpg",
    user: user3,
    is_publish: false
  }
  {
    title: "沖縄の海",
    body: "透明度がすごかった！",
    image: "sample-post7.jpg",
    user: user3,
    is_publish: true
  }
  {
    title: "沖縄の海",
    body: "透明度がすごかった！",
    image: nil,
    user: user3,
    is_publish: true
  }
]
  posts.each do |data|
  post = Post.find_or_create_by!(title: data[:title]) do |p|
    p.body = data[:body]
    p.user = data[:user]
    p.is_publish = data[:is_publish]
  end

  unless post.image.attached?
    post.image.attach(
      io: File.open(Rails.root.join("db/fixtures/#{data[:image]}")),
      filename: data[:image]
    )
  end
end