# == Schema Information
#
# Table name: foods
#
#  id          :integer          not null, primary key
#  slovakname  :string(255)      not null
#  englishname :string(255)
#  description :text
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#

class Food < ActiveRecord::Base
  attr_accessible :category,:slovakname, :englishname, :description, :user, :menus, :types, :compositions, :recipes,
                  :id, :category_id, :user_id


  include PgSearch

  multisearchable :against => [:slovakname, :englishname]


  pg_search_scope :regular_search,
                  :against => :slovakname

  pg_search_scope :kinda_spelled_like,
                  :against => :slovakname,
                  :using => :trigram

  pg_search_scope :gringo_search,
                  :against => :slovakname,
                  :ignoring => :accents

  belongs_to :user

  belongs_to :category

  has_many :menus_foods,:dependent => :destroy
  has_many :menus, :through => :menus_foods,:dependent => :destroy

  has_many :foods_types, :dependent => :destroy
  has_many :types, :through => :foods_types, :dependent => :destroy

  has_many :compositions,:dependent => :destroy

  has_many :recipes,:dependent => :destroy

end
