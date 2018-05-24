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

require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
