# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name: 'Rails', description:'Ruby on Rails', sort_key: 1)
Category.create(name: 'iOS', description: 'Objective-C, Xcode etc', sort_key: 2)
Category.create(name: 'Android', description: 'Java, Android', sort_key: 3)
Category.create(name: 'プロセス', description: 'Agile, DevOps etc', sort_key: 4)
Category.create(name: 'インフラ', description: 'server-related, network-related', sort_key: 5)
Category.create(name: 'キャリア', description: 'carrier choice', sort_key: 6)

Feed.create(name: 'はてぶ', url: 'http://b.hatena.ne.jp/search/text?q=Rails&mode=rss', category_id: 1)
Feed.create(name: 'はてぶ', url: 'http://b.hatena.ne.jp/search/text?q=iOS&mode=rss', category_id: 2)
Feed.create(name: 'はてぶ', url: 'http://b.hatena.ne.jp/search/text?q=Android&mode=rss', category_id: 3)
Feed.create(name: 'はてぶ', url: 'http://b.hatena.ne.jp/search/text?q=DevOps&mode=rss', category_id: 4)
Feed.create(name: 'はてぶ', url: 'http://b.hatena.ne.jp/search/text?q=インフラ&mode=rss', category_id: 5)
Feed.create(name: 'はてぶ', url: 'http://b.hatena.ne.jp/search/text?q=キャリア&mode=rss', category_id: 6)

