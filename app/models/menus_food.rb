# == Schema Information
#
# Table name: menus_foods
#
#  id         :integer          not null, primary key
#  menu_id    :integer          not null
#  food_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MenusFood < ActiveRecord::Base
  attr_accessible :food, :menu, :amount

  belongs_to :menu
  belongs_to :food
end
