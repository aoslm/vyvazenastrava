# == Schema Information
#
# Table name: types_categories
#
#  id          :integer          not null, primary key
#  type_id     :integer          not null
#  category_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class TypesCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
