# == Schema Information
#
# Table name: accounts
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Account < ApplicationRecord
  has_many :posts, inverse_of: 'author', dependent: :destroy

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  has_many :likes
  has_many :liked_posts, through: :likes, source: :likeable, source_type: "Post"

  def follow(account)
    begin
    following_relationships.create(following_id: account.id)
    rescue ActiveRecord::RecordNotUnique => e
      puts "duplicated record fo Account.id=#{account.id}"
    end
  end

  def unfollow(account)
    following_relationships.find_by(following_id: account.id).destroy
  end

  def generate_follows(number)
    max_qty = Account.count
    number.times do
      follow(Account.find(rand(1..max_qty)))
    end
  end

end

