# == Schema Information
#
# Table name: users_recipes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  recipe_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UsersRecipe < ActiveRecord::Base
  attr_accessible :recipe, :user

  belongs_to :user
  belongs_to :recipe
end
