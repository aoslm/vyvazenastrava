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

require 'test_helper'

class CompositionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
