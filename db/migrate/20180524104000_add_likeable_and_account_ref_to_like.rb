class AddLikeableAndAccountRefToLike < ActiveRecord::Migration[5.2]
  def change
    add_reference :likes, :likeable, polymorphic: true, index: true
    add_reference :likes, :account, foreign_key: true
  end
end
