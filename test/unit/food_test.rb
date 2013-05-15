# == Schema Information
#
# Table name: foods
#
#  id          :integer          not null, primary key
#  slovakname  :string(255)      not null
#  englishname :string(255)
#  description :text
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#

require 'test_helper'

class FoodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
