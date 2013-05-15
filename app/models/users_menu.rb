# == Schema Information
#
# Table name: users_menus
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  menu_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UsersMenu < ActiveRecord::Base
  attr_accessible :menu, :user

  belongs_to :user
  belongs_to :menu
end
