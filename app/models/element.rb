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

class Element < ActiveRecord::Base
  attr_accessible :amount, :composition, :elements_type, :composition_id, :elements_type_id

  belongs_to :composition
  belongs_to :elements_type
end
