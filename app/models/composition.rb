# == Schema Information
#
# Table name: compositions
#
#  id         :integer          not null, primary key
#  rank       :integer
#  user_id    :integer
#  food_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Composition < ActiveRecord::Base
  attr_accessible :rank, :food, :user, :elements, :food_id, :user_id


  has_many :elements,:dependent => :destroy

  belongs_to :food
  belongs_to :user

end
