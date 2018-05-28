# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  account_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  belongs_to :author, class_name: 'Account', foreign_key: :account_id
  scope :of_followed_users, -> (following_users) { where account_id: following_users }
  scope :liked_by_me_and_followed_users_of, ->(account) { where(id: Like.where(account_id: account.following)).or(where id: account.likes)}

  has_many :likes, as: :likeable
  has_many :liking_users, through: :likes, source: :account

end
