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

class TypesCategory < ActiveRecord::Base
  attr_accessible :type, :category

  belongs_to :type
  belongs_to :category
end
