# == Schema Information
#
# Table name: foods_types
#
#  id         :integer          not null, primary key
#  food_id    :integer          not null
#  type_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FoodsType < ActiveRecord::Base
  attr_accessible :food, :type, :food_id, :type_id

  belongs_to :food
  belongs_to :type
end
