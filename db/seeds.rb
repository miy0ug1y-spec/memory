puts "seedの実行を開始" 

genres = { family: Genre.find_or_create_by!(name: "家族"), 
           pet: Genre.find_or_create_by!(name: "ペット"), 
           lover: Genre.find_or_create_by!(name: "恋人"), 
           friend: Genre.find_or_create_by!(name: "友人"), 
           other: Genre.find_or_create_by!(name: "その他") } 


puts "ジャンル作成完了" 

users = [
   { 
    last_name: "山田", 
    first_name: "太郎", 
    handle_name: "うでながおじさん", 
    email_address: "user1@example.com", 
    password: "password", 
    birthday: Date.new(1975, 5,1), 
    gender: :male, image: "sample-user1.jpg", 
    introduction: "日々徒然と思いを綴っています。" 
  },
  { last_name: "佐藤", 
    first_name: "花子", 
    handle_name: "微糖ママ", 
    email_address: "user2@example.com", 
    password: "password", 
    birthday: Date.new(1980,8,1), 
    gender: :female, image: "sample-user2.png", 
    introduction: "母との思い出や、日々感じたことを書いています。" 
  },
  { 
    last_name: "河村", 
    first_name: "次彦", 
    handle_name: "KaKa@z", 
    email_address: "user3@example.com", 
    password: "password", birthday: Date.new(1985,1,1), 
    gender: :male, 
    image: nil, 
    introduction: "愛犬きなことの思い出を残すために利用しています。" 
  },
  { 
    last_name: "鈴木", 
    first_name: "一朗", 
    handle_name: "ほのぼの", 
    email_address: "user4@example.com", 
    password: "password", 
    birthday: Date.new(1970,4,1), 
    gender: :male, 
    image: "sample-user4.png", 
    introduction: "大切な人との記憶をゆっくり残していきたいです。" 
  },
  { last_name: "佐々木", 
    first_name: "一子", 
    handle_name: "クズモチ", 
    email_address: "user5@example.com", 
    password: "password", 
    birthday: Date.new(1970,7,1), 
    gender: :female, 
    image: "sample-user5.jpg", 
    introduction: "思い出したことを書き出しています。" 
  },
  { 
    last_name: "吉田", 
    first_name: "三郎", 
    handle_name: "sub_chan", 
    email_address: "user6@example.com", 
    password: "password", 
    birthday: Date.new(1965,10,1), 
    gender: :male, 
    image: "sample-user6.jpg", 
    introduction: "前向きになりたいです。"
   },
   { 
    last_name: "伊藤", 
    first_name: "二実", 
    handle_name: "たどたど椎の実", 
    email_address: "user7@example.com", 
    password: "password", 
    birthday: Date.new(1960,2,1),
    gender: :female, 
    image: "sample-user7.jpg", 
    introduction: "こちらは元気にやってます" 
  },
  { 
    last_name: "田中", 
    first_name: "史郎", 
    handle_name: "氷水", 
    email_address: "user8@example.com", 
    password: "password", 
    birthday: Date.new(1955,5,1), 
    gender: :male, 
    image: "sample-user8.jpg", 
    introduction: "孫と過ごす時間は至福"
   },
   { 
    last_name: "岡田", 
    first_name: "三津子", 
    handle_name: "an☆mitsu", 
    email_address: "user9@example.com", 
    password: "password", 
    birthday: Date.new(1950,8,1), 
    gender: :female, 
    image: "sample-user9.jpg", 
    introduction: "心の平穏を大事にしてます" 
  },
  { 
    last_name: "原口", 
    first_name: "五郎丸", 
    handle_name: "まるちゃん", 
    email_address: "user10@example.com", 
    password: "password", 
    birthday: Date.new(1965,10,1), 
    gender: :male, 
    image: "sample-user10.jpg", 
    introduction: "前向きになりたいです。" 
    } 
  ]

created_users = users.map.with_index(1) do |data, index| 
  user = User.find_or_initialize_by(email_address: data[:email_address])

  user.assign_attributes( 
    last_name: data[:last_name], 
    first_name: data[:first_name], 
    handle_name: data[:handle_name], 
    password: data[:password], 
    password_confirmation: data[:password], 
    birthday: data[:birthday], 
    gender: data[:gender], 
    introduction: data[:introduction] 
    )

user.save!

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
user4 = created_users[3] 
user5 = created_users[4] 
user6 = created_users[5] 
user7 = created_users[6] 
user8 = created_users[7] 
user9 = created_users[8] 
user10 = created_users[9]

posts = [
  {
    title: "巡礼の旅(鹿児島編)",
    body: "新婚旅行で行った屋久島に行ってきました。妻と行ったときは悪天候でずっと雨が降っていたけど、今回も雨！「雨露に光った木々も綺麗よ」なんて言っていたから雨でも悪くないと思ったんだよなあ。",
    image: "sample-post1.png",
    user: user1,
    genre: genres[:family],
    is_publish: true
  },
  {
    title: "巡礼の旅(静岡編)",
    body: "夫婦二人で富士山を見るのが好きでした。今日は駿河湾に行ってきました。今は海で供養もできるんですね。いい天気でよかった。",
    image: "sample-post2.png",
    user: user1,
    genre: genres[:family], 
    is_publish: true
  },
  {
    title: "夢に出てきた",
    body: "久しぶりに夢に出てきた。内容はほとんど覚えてないけど、元気そうだった。それだけで今日は少し嬉しい。",
    image: nil,
    user: user1,
    genre: genres[:family],
    is_publish: false
  },
  {
    title: "私が優しい娘だったら良かった",
    body: "お母さんが突然いなくなってしまって悲しい。還暦のお祝いだってしたかった。口答えばっかりする娘でごめんなさい。お母さんが優しいからすっかり甘えていました。",
    image: "sample-post3.png",
    user: user2,
    genre: genres[:family],
    is_publish: false
  },
  {
    title: "お好み焼きが食べられなくなりました",
    body: "母が最期に食べたものがお好み焼きでした。普段粉ものは食べないのに、私が高校生の時によく部活の打ち上げで使っていたお店に私を懐かしんで行ってくれたみたいでした。未だにお好み焼きを見ると心がぎゅっとします。",
    image: nil,
    user: user2,
    genre: genres[:family],
    is_publish: true
  },
  {
    title: "チューリップが咲いていました",
    body: "母のスマホのフォルダに自撮りしたチューリップ畑の写真が残ってたから、チューリップを見ると母を思いだします。またこの季節がきたんだと、時の流れを感じました。",
    image: "sample-post4.webp",
    user: user2,
    genre: genres[:family],
    is_publish: true
  },
  {
    title: "きなこ【1】",
    body: "毎日一緒に過ごして、帰ってくると出迎えてくれてたのになんでもう亡くなってしまったの？家から何の音もしない。",
    image: "sample-post5.webp",
    user: user3,
    genre: genres[:pet],
    is_publish: false
  },
  {
    title: "きなこ【2】",
    body: "スマホの写真を整理しようと思ったけど、途中で手が止まってしまった。消せない写真ばかり。今日はここまでにします。",
    image: "sample-post6.webp",
    user: user3,
    genre: genres[:pet],
    is_publish: true
  },
  {
    title: "さんぽみち①",
    body: "きなこの大好きな河原の土手道。いつも一緒に散歩した。オナモミをよくしっぽにくっつかせてパタパタしてるのがかわいかった。きなことの思い出。",
    image: "sample-post7.webp",
    user: user3,
    genre: genres[:pet],
    is_publish: true
  },
  {
    title: "古いレシピ帳",
    body: "家を整理していたら家内が使っていたレシピ帳が出てきました。分量が適当だったり、端っこにメモが書いてあったりして家内らしいなと思いました。今度このレシピで煮物を作ってみようと思います。",
    image: "sample-post4.png",
    user: user4,
    genre: genres[:family],
    is_publish: true
  },
  { 
    title: "久しぶりに海へ", 
    body: "久しぶりに二人でよく行った海までドライブしました。昔と変わらない景色を見ていたら、隣にいるような気がしました。少しずつですが、楽しかったことも思い出せるようになってきた。", 
    image: "sample-post5.png", 
    user: user5, 
    genre: genres[:lover], 
    is_publish: true 
  },
  { 
    title: "学生時代の写真", 
    body: "片付けをしていたら学生時代の写真が出てきました。みんな若くて、服装も髪型も懐かしい。あの頃は毎日のように一緒にいたのにね。写真を見ながら久しぶりにたくさん笑いました。", 
    image: "sample-post6.png", 
    user: user6, 
    genre: genres[:friend], 
    is_publish: true 
  },
  { 
    title: "昔よく通った喫茶店", 
    body: "友人とよく通っていた喫茶店に久しぶりに行きました。まだ同じ場所にあって嬉しかったです。いつも同じ席に座って何時間も話していたことを思い出しました。", 
    image: "sample-post7.png", 
    user: user7, 
    genre: genres[:friend], 
    is_publish: true 
  },
  { 
    title: "朝の散歩をしてみた", 
    body: "気分がすこし楽になった気がする。やっぱり運動は体にいいんだな。", 
    image: "sample-post8.png", 
    user: user8, 
    genre: genres[:family], 
    is_publish: true 
  },
  { 
    title: "恩師の腕時計", 
    body: "師匠がずっと使っていた腕時計を譲り受けました。少し傷がついていて、ベルトも古くなっていますが、それも含めて師匠らしい気がします。大切に使っていこうと思います。", 
    image: "sample-post9.png", 
    user: user9, 
    genre: genres[:other], 
    is_publish: true 
  },
  { 
    title: "遺影", 
    body: "この前の旅行。楽しかった。いい笑顔で取れていたと思う。遺影にしてくれると嬉しい。", 
    image: "sample-post10.png", 
    user: user10, 
    genre: genres[:family], 
    is_publish: false 
  },
  { 
    title: "今日は月命日", 
    body: "今日は月命日。好きだった花を買ってきました。また来月ね。", 
    image: "sample-post11.png", 
    user: user3, 
    genre: genres[:pet], 
    is_publish: true 
  },
  { 
    title: "庭の金木犀", 
    body: "今年も庭の金木犀が咲きました。この香りがすると昔のことをよく思い出します。季節はちゃんと巡ってくるんだなあと、少し不思議な気持ちになりました。", 
    image: "sample-post12.png", 
    user: user9, 
    genre: genres[:other], 
    is_publish: true 
  },
  { 
    title: "今年も桜が咲きました", 
    body: "今年も近所の公園の桜が満開になりました。毎年一緒に見に行っていたので、この季節になると自然と思い出します。今年は一人だけど、やっぱり桜はきれいでした。", 
    image: nil, 
    user: user5, 
    genre: genres[:lover], 
    is_publish: true 
  },
  { 
    title: "まだ整理できない気持ち", 
    body: "誰かに読んでもらうには、まだ自分の中で整理できていないので、今日はここにだけ残しておきます。", 
    image: nil, 
    user: user8, 
    genre: genres[:family], 
    is_publish: false 
    } 
  ]

created_posts = {}

posts.each do |data| 
  post = Post.find_or_initialize_by(title: data[:title], user: data[:user]) 
  post.assign_attributes( 
    body: data[:body], 
    genre: data[:genre], 
    is_publish: data[:is_publish] 
  )

post.save!

  if data[:image].present? && !post.image.attached?
    post.image.attach(
      io: File.open(Rails.root.join("db/fixtures/#{data[:image]}")),
      filename: data[:image]
    )
  end

  created_posts[data[:title]] = post
end


puts "フォローデータ作成開始"

relationships = [
  [user1, user2],
  [user1, user3],
  [user1, user4],

  [user2, user1],
  [user2, user5],

  [user3, user1],
  [user3, user6],

  [user4, user1],
  [user5, user2],
  [user6, user3],
  [user7, user2],
  [user8, user1],
  [user9, user1],
  [user10, user4]
]

relationships.each do |follower, followed|
  Relationship.find_or_create_by!(
    follower: follower,
    followed: followed
  )
end



puts "コメント作成開始"

comments = [
  {
    user: user2,
    post: created_posts["巡礼の旅(鹿児島編)"],
    content: "屋久島、素敵ですね。雨の日の景色もきれいですよね。"
  },
  {
    user: user3,
    post: created_posts["巡礼の旅(静岡編)"],
    content: "思い出の場所を訪れるのも素敵だと思いました。"
  },
  {
    user: user1,
    post: created_posts["お好み焼きが食べられなくなりました"],
    content: "食べ物と記憶って強く結びついていますよね。"
  },
   {
    user: user4,
    post: created_posts["チューリップが咲いていました"],
    content: "季節が来るたびに思い出すこと、ありますね。"
  },

  {
    user: user5,
    post: created_posts["さんぽみち①"],
    content: "散歩道にはたくさん思い出が残っていますよね。"
  },
 {
    user: user6,
    post: created_posts["恩師の腕時計"],
    content: "大切な形見ですね。これからも一緒に時を刻めますね。"
  }, 
  {
    user: user7,
    post: created_posts["チューリップが咲いていました"],
    content: "香りで記憶がよみがえること、私もあります。"
  }, 
  {
    user: user8,
    post: created_posts["チューリップが咲いていました"],
    content: "香りで記憶がよみがえること、私もあります。"
  }, 
  {
    user: user9,
    post: created_posts["昔よく通った喫茶店"],
    content: "変わらず残っている場所を見ると嬉しくなりますね。"
  }, 
]

comments.each do |data|
  Comment.find_or_create_by!(
    user: data[:user],
    post: data[:post],
    content: data[:content]
  )
end

puts "コメント完了"

puts "コミュニティ開始"

group1 = Group.find_or_initialize_by(name: "思い出の場所への旅")
group1.assign_attributes(
  owner: user1,
  introduction: "大切な人とかつて訪れた場所をたずねて、心のピースを埋めませんか？" 
)

group1.save!

group1.image.purge if group1.image.attached?

group1.image.attach(
  io: File.open(
    Rails.root.join("db/fixtures/sample-group1.jpg")
  ),
  filename: "sample-group1.jpg",
  content_type: "image/jpeg"
)


group2 = Group.find_or_initialize_by(name: "1日1個良かったことをつぶやく会")
group2.assign_attributes(
  owner: user2,
  introduction: "いいことや楽しかったことに意識を向けると、悲しい記憶を思い出しにくくなるのだそうです。ここで一緒に1日の良かった出来事をつぶやきましょう！" 
)

group2.save!

group2.image.purge if group2.image.attached?

group2.image.attach(
  io: File.open(
    Rails.root.join("db/fixtures/sample-group2.jpg")
  ),
  filename: "sample-group2.jpg",
  content_type: "image/jpeg"
)

group3 = Group.find_or_initialize_by(name: "ゆっくり前を向く会")
group3.assign_attributes(
  owner: user6,
  introduction: "焦らず、自分のペースで気持ちを話せる場所です。"
)
group3.save!

puts "コミュニティ完了"

puts "コミュニティ参加データ作成開始"

memberships = [
  [user1, group1, :approved],
  [user2, group1, :approved],
  [user4, group1, :approved],
  [user5, group1, :pending],

  [user2, group2, :approved],
  [user3, group2, :approved],
  [user7, group2, :approved],
  [user8, group2, :pending],

  [user6, group3, :approved],
  [user9, group3, :approved],
  [user10, group3, :pending]
]

memberships.each do |user, group, status|
  membership = GroupMembership.find_or_initialize_by(
    user: user,
    group: group
  )

  membership.status = status
  membership.save!
end

puts "コミュニティ参加データ作成完了"

puts "コミュニティコメント開始"

GroupMessage.find_or_create_by!(
  user: user2,
  group: group1,
  content: "よろしくお願いします。皆さんの思い出もゆっくり読ませてもらいます。"
)

GroupMessage.find_or_create_by!(
  user: user1,
  group: group1,
  content: "参加ありがとうございます。無理せず自分のペースで交流してください。"
)


puts "コミュニティコメント完了"

puts "MyEnding作成開始"

ending1 = Ending.find_or_initialize_by(user: user1)

ending1.assign_attributes(
  feeling: "これまで一緒に過ごしてくれてありがとう。たくさんの思い出を残してくれたことに感謝しています。",
  episode: "新婚旅行で訪れた屋久島のことを今でもよく思い出します。雨の中を歩いたことも、今では大切な思い出です。"
)

ending1.save!

ending1.posts = [
  created_posts["巡礼の旅(鹿児島編)"],
  created_posts["巡礼の旅(静岡編)"]
].compact

unless ending1.image.attached?
  ending1.image.attach(
    io: File.open(
      Rails.root.join("db/fixtures/sample-ending-video.mp4")
    ),
    filename: "sample-ending-video.mp4",
    content_type: "video/mp4"
  )
end

ending2 = Ending.find_or_initialize_by(user: user2)

ending2.assign_attributes(
  feeling: "なかなか素直に言えなかったけれど、本当にありがとう。これからも思い出を大切にしていきます。",
  episode: "母と一緒に過ごした何気ない毎日が、今になって一番大切だったと感じます。"
)

ending2.save!

ending2.posts = [
  created_posts["お好み焼きが食べられなくなりました"],
  created_posts["チューリップが咲いていました"]
].compact

unless ending2.image.attached?
  ending2.image.attach(
    io: File.open(
      Rails.root.join("db/fixtures/sample-ending-image.png")
    ),
    filename: "sample-ending-image.png",
    content_type: "image/png"
  )
end

ending3 = Ending.find_or_initialize_by(user: user10)

ending3.assign_attributes(
  feeling: "これまで一緒に過ごせたこと、感謝しています。",
  episode: "子供たちが生まれて、孫にも恵まれてとても幸せでした。"
)

ending3.save!

ending3.posts = [
  created_posts["遺影"]
].compact



puts "MyEnding作成完了"


puts "seedの実行が完了しました"