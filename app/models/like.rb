# == Schema Information
#
# Table name: likes
#
#  id            :bigint(8)        not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  likeable_type :string
#  likeable_id   :bigint(8)
#  account_id    :bigint(8)
#

class Like < ApplicationRecord
  belongs_to :account
  belongs_to :likeable, polymorphic: true
  belongs_to :post, optional: true #?
end
