# == Schema Information
#
# Table name: recipes
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  price      :float
#  rank       :integer
#  time       :time
#  manual     :text
#  food_id    :integer          not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Recipe < ActiveRecord::Base
  attr_accessible :name,:time, :manual, :price, :rank, :food, :users, :people

  has_many :users_recipes,:dependent => :destroy
  has_many :users, :through => :users_recipes ,:dependent => :destroy

  belongs_to :food

end
