class ElementTypeGroup < ActiveRecord::Base
  attr_accessible :name, :description, :elements_types
  has_many :elements_types
end
