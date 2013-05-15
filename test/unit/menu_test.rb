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

require 'test_helper'

class MenuTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
