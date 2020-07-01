class Post < ApplicationRecord

  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  belongs_to :user

  has_many :photos, dependent: :destroy

  accepts_nested_attributes_for :photos

end
