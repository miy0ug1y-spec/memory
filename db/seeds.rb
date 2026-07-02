# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "seedの実行を開始"

users = [
  { 
    name: "山田太郎",
    handle_name: "うでながおじさん",
    password: "password",
    image: "sample-user1.jpg"
  },
  {
    name: "佐藤花子",
    handle_name: "微糖ママ",
    password: "password",
    image: "sample-user2.png"
  },
  {
    name: "河村次彦",
    handle_name: "KaKa@z",
    password: "password",
    image: nil
  }
]

created_users = users.map.with_index(1) do |data, index|
  user = User.find_or_create_by!(email_address: "user#{index}@example.com") do |u|
    u.name = data[:name]
    u.handle_name = data[:handle_name]
    u.password = data[:password]
  end

  if data[:image].present? && !user.image.attached?
    user.image.attach(
      io: File.open(Rails.root.join("db/fixtures/#{data[:image]}")),
      filename: data[:image]
    )
  end

  user
end


user1 = created_users[0]
user2 = created_users[1]
user3 = created_users[2]


posts = [
  {
    title: "巡礼の旅(鹿児島編)",
    body: "新婚旅行で行った屋久島に行ってきました。千代子と行ったときは悪天候でずっと雨が降っていたけど、今回も雨！「雨露に光った木々も綺麗よ」なんて言っていたから雨でも悪くないと思ったんだよなあ。",
    image: "sample-post1.png",
    user: user1,
    is_publish: true
  },
  {
    title: "巡礼の旅(静岡編)",
    body: "夫婦二人で富士山を見るのが好きでした。業者にお願いして駿河湾に海洋散骨をしてきました。いい天気でよかったなあ。千代子、綺麗な富士がいつでも見られるぞ。",
    image: "sample-post2.png",
    user: user1,
    is_publish: true
  },
  {
    title: "千代子ありがとう",
    body: "今日もまだ朝がきて千代子がいないことを信じられないでいる。もう千代子に会えないのが本当に苦しい。けど奈々子たちも心配してくれていろいろと世話を焼いてくれる。俺たちの生きた証はここに遺ってる。",
    image: nil,
    user: user1,
    is_publish: false
  },
  {
    title: "私が優しい娘だったら良かった",
    body: "お母さんが突然いなくなってしまって悲しい。還暦のお祝いだってしたかった。口答えばっかりする娘でごめんなさい。お母さんが優しいからすっかり甘えていました。",
    image: "sample-post3.png",
    user: user2,
    is_publish: false
  },
  {
    title: "お好み焼きはまだ食べられません",
    body: "母が最期に食べたものがお好み焼きでした。普段粉ものは食べないのに、私が高校生の時によく部活の打ち上げで使っていたお店に私を懐かしんで行ってくれたみたいでした。未だにお好み焼きを見ると心がぎゅっとします。",
    image: nil,
    user: user2,
    is_publish: true
  },
  {
    title: "チューリップが咲いていました",
    body: "母のスマホのフォルダに自撮りしたチューリップ畑の写真が残ってたから、チューリップを見ると母を思いだします。またこの季節がきたんだと、時の流れを感じました。",
    image: "sample-post4.webp",
    user: user2,
    is_publish: true
  },
  {
    title: "きなこ【1】",
    body: "毎日一緒に過ごして、帰ってくると出迎えてくれてたのになんでもう逝っちゃったの？家から何の音もしない。",
    image: "sample-post5.webp",
    user: user3,
    is_publish: false
  },
  {
    title: "きなこ【2】",
    body: "写真を見るだけで涙が出てくる。大好きなボールでもっといっぱい遊んであげればよかった。また飼えばいいなんて受け入れられない。",
    image: "sample-post6.webp",
    user: user3,
    is_publish: false
  },
  {
    title: "さんぽみち①",
    body: "きなこの大好きな河原の土手道。いつも一緒に散歩した。オナモミをよくしっぽにくっつかせてパタパタしてるのがかわいかった。きなことの思い出が残ってる。",
    image: "sample-post7.webp",
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

  if data[:image].present? && !post.image.attached?
    post.image.attach(
      io: File.open(Rails.root.join("db/fixtures/#{data[:image]}")),
      filename: data[:image]
    )
  end
end

puts "seedの実行が完了しました"
