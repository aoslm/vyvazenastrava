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

require 'test_helper'

class FoodsTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
