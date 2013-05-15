# == Schema Information
#
# Table name: menus
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  food_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#  rank       :integer
#

class Menu < ActiveRecord::Base
  attr_accessible :users,:foods, :name
  # belongs_to :menuable, :polymorphic => true

  has_many :users_menus,:dependent => :destroy
  has_many :users, :through => :users_menus ,:dependent => :destroy

  has_many :menus_foods,:dependent => :destroy
  has_many :foods, :through => :menus_foods ,:dependent => :destroy

end
