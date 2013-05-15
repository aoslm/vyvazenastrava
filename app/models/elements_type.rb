# == Schema Information
#
# Table name: elements_types
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  description :text
#  GDA_man     :float
#  GDA_woman   :float
#  GDA_child   :float
#  unit        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ElementsType < ActiveRecord::Base
  attr_accessible :id, :description, :elements, :name, :GDA_man, :GDA_child, :GDA_woman, :unit, :updated_at,
                  :created_at;

  has_many :elements

  belongs_to :element_type_group
end
