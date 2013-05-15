# == Schema Information
#
# Table name: types
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Type < ActiveRecord::Base
  attr_accessible :description, :name,:foods, :categories

  has_many :foods_types ,:dependent => :destroy
  has_many :foods, :through => :foods_types,:dependent => :destroy

  has_many :types_categories,:dependent => :destroy
  has_many :categories, :through => :types_categories,:dependent => :destroy
end
