# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# (1..100).each do
#   Account.create
# end
#
# accounts = Account.all
#
# accounts[0].follow accounts[1].id
# accounts[1].follow accounts[2].id
# accounts[2].follow accounts[3].id
#
# accounts[0].follow accounts[10].id
# accounts[0].follow accounts[20].id
# accounts[0].follow accounts[30].id
# accounts[0].follow accounts[40].id
# accounts[0].follow accounts[50].id
#
# accounts[1].follow accounts[11].id
# accounts[1].follow accounts[21].id
# accounts[1].follow accounts[31].id
# accounts[1].follow accounts[41].id
# accounts[1].follow accounts[51].id
# accounts[1].follow accounts[61].id
# accounts[1].follow accounts[71].id
#
# accounts[3].follow accounts[13].id
# accounts[3].follow accounts[23].id
# accounts[3].follow accounts[33].id
# accounts[3].follow accounts[43].id
# accounts[3].follow accounts[53].id
# accounts[3].follow accounts[63].id
# accounts[3].follow accounts[73].id
# accounts[3].follow accounts[83].id
# accounts[3].follow accounts[93].id
#
#
# (1..3).each do |i|
#   (i ** i).times do
#     accounts[i].posts.create
#   end
# end

puts "== Seeding DB"

#a1 = Account.create
#a2 = Account.create
#a3 = Account.create
#a4 = Account.create
#a5 = Account.create
#a6 = Account.create

#p1 = a1.posts.create
#p2 = a2.posts.create
#p3 = a3.posts.create
#p4 = a4.posts.create
#p5 = a5.posts.create
#p6 = a1.posts.create
#p7 = a2.posts.create
#p8 = a2.posts.create

#a1.follow a2
#a1.follow a3
#a3.follow a1
#a2.follow a1

#a3.follow a4
#a3.follow a6
#a6.follow a3

#a4.follow a5
#a4.follow a6
#a6.follow a4


#a1.likes.create likeable: p1
#a1.likes.create likeable: p2
#a1.likes.create likeable: p3

#a3.likes.create likeable: p4
#a3.likes.create likeable: p5
#a3.likes.create likeable: p6

#a6.likes.create likeable: p7
#a6.likes.create likeable: p8


ACCOUNTS = 50000
MAX_FOLLOWERS_PER_ACC = 50

MIN_LIKES_PER_POST = 50
MAX_LIKES_PER_POST = 200

MIN_POSTS_PER_ACC = 50
MAX_POSTS_PER_ACC = 150

STDOUT.write "\a"
STDOUT.write "\n== Do you want populate DB with #{ACCOUNTS} users? [y/n] "
answer = STDIN.gets.chomp
if answer == "y"
  accounts = []

  (1..ACCOUNTS).each do |i|
    accounts << {id: i}
    STDOUT.write "\r   Generated #{i} of #{ACCOUNTS}"
  end
  puts "....Importing to DB...                        "
  Account.import accounts, batch_size: 1000

  follows = []

  (1..ACCOUNTS).each do |i|

    (rand(MAX_FOLLOWERS_PER_ACC..MAX_FOLLOWERS_PER_ACC * 3)).times do
      follows << {following_id: rand(1..ACCOUNTS), follower_id: i}
    end
    STDOUT.write "\r   Generated followers for account #{i} of #{ACCOUNTS}"

  end

  puts "....Importing #{follows.count} follows to DB..."

  Follow.import follows, validate: false, on_duplicate_key_ignore: true, batch_size: 1000

end

puts "\a"
STDOUT.write "\n== Do you want populate DB with posts? [y/n] "
answer = STDIN.gets.chomp
if answer == "y"

  posts = []

  (1..ACCOUNTS).each do |i|
    rand(MIN_POSTS_PER_ACC..MAX_POSTS_PER_ACC).times do
      posts << {account_id: i}
    end
    STDOUT.write "\r   Generated posts for account #{i} of #{ACCOUNTS}"
  end

  puts "....Importing #{posts.count} posts to DB..."

  #Post.import posts, validate: false, on_duplicate_key_ignore: true, batch_size: 1000


  likes = []

  (1..ACCOUNTS).each do |i|
    rand(MIN_LIKES_PER_POST..MAX_LIKES_PER_POST).times do
      likes << {likeable_type: 'Post', likeable_id: rand(1..posts.count), account_id: i}
    end
    STDOUT.write "\r   Generated likes for account #{i} of #{ACCOUNTS}"
  end

  puts "....Importing #{likes.count} likes to DB..."

  Like.import likes, validate: false, on_duplicate_key_ignore: true, batch_size: 1000

  #
  # Account.find_each do |account|
  #
  #   POSTS_PER_ACC.times {account.posts.create}
  #   STDOUT.write "\r   Generated posts for account.id=#{account.id} of #{ACCOUNTS}"
  # end
  #
  # puts "== Generating likes for posts"
  #
  # Account.find_each do |account|
  #   account.generate_likes(rand(MAX_LIKES_PER_POST..MAX_LIKES_PER_POST * 2))
  #   STDOUT.write "\r   Generated likes for posts of account.id=#{account.id} of #{ACCOUNTS}"
  # end

end