# == Schema Information
#
# Table name: type_of_elements
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  GDA_man     :float
#  unit        :string(255)
#  GDA_woman   :float
#  GDA_child   :float
#

require 'test_helper'

class ElementTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
