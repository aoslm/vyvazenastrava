# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Category < ActiveRecord::Base
  attr_accessible :description, :name, :types, :foods, :id

  has_many :foods
  has_many :types_categories,:dependent => :destroy
  has_many :types, :through => :types_categories,:dependent => :destroy
end
