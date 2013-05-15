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

require 'test_helper'

class MenusFoodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
