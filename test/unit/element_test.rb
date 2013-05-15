# == Schema Information
#
# Table name: elements
#
#  id               :integer          not null, primary key
#  amount           :float            not null
#  composition_id   :integer          not null
#  elements_type_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class ElementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
