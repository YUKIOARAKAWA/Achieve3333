# == Schema Information
#
# Table name: blogs
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Blog < ActiveRecord::Base


  # アソシエーション
  belongs_to :user

  # バリデーション
  validates :user_id, presence: true
  validates :content, presence: true
end
