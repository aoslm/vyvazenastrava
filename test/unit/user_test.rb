# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  username              :string(255)      not null
#  name                  :string(255)
#  surname               :string(255)
#  password_digest       :string(255)
#  address               :string(255)
#  rank                  :integer
#  dateOfBirth           :date
#  email                 :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  password              :string(255)
#  password_confirmation :string(255)
#  remember_token        :string(255)
#  gender                :string(255)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
