user = User.create(name: "seed_user1", email: "seed1@seed.com", admin: true, password: "password01")
user = User.create(name: "seed_user2", email: "seed2@seed.com", admin: true, password: "password02")
user = User.create(name: "seed_user3", email: "seed3@seed.com", admin: false, password: "password03")
user = User.create(name: "seed_user4", email: "seed4@seed.com", admin: false, password: "password04")
user = User.create(name: "seed_user5", email: "seed5@seed.com", admin: false, password: "password05")

30.times { |n|
  Review.create(name: "basic_user#{n}", title: "test_title#{n}", problem: "test_problem#{n}", detail: "test_detail#{n}", solution: "test_solution#{n}", content: "test_content#{n}", user_id: user.id )
}

lavels = [
      { name: 'HTML / CSS' },
      { name: 'Javascript（Jquery）' },
      { name: 'C' },
      { name: 'C++' },
      { name: 'C#' },
      { name: 'PHP' },
      { name: 'Laravel' },
      { name: 'Ruby' },
      { name: 'Ruby on Rails' },
      { name: 'Java / Kotlin' },
      { name: 'Swift / Objective-C' },
      { name: 'Python' },
      { name: 'Django / Flask' },
      { name: 'Go（Golang）' },
      { name: 'React' },
      { name: '書籍' },
      { name: 'youtube' },
      { name: 'ドットインストール' },
      { name: 'progate' },
      { name: 'Udemy' },
      { name: 'Techpit' },
      { name: 'paiza' },
      { name: 'Qiita' },
      { name: 'zenn' },
      { name: '【書籍】分厚い' },
      { name: '【書籍】薄い' },
      { name: '電子書籍あり' },
      { name: '初学者向け' },
      { name: '中上級' },
      { name: '【書籍・サイト】解説動画あり' },
      { name: '実務向け' },
      { name: '【作者】現役エンジニア' },
      { name: '【作者】スクール講師' },
      { name: '【作者】スクールメンター' },
      { name: '【動画】10分以内（倍速なし）' },
      { name: '【動画】1時間未満（倍速なし）' },
      { name: '【動画】1時間超え（倍速なし）' },
      { name: '【動画】喋り：速い' },
      { name: '【動画】喋り：ゆっくり' },
      { name: '【動画】喋り：普通' },
      { name: '【料金】無料' },
      { name: '【料金】有料' }
]
Label.create(lavels)