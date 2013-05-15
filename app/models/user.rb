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

class User < ActiveRecord::Base
  attr_accessible :username,  :email, :name, :surname, :dateOfBirth, :address, :rank, :foods, :recipes,
                  :compositions, :menus, :password, :password_confirmation, :id, :gender

  has_secure_password

  before_save { |user| user.email = email.downcase; user.username = username.downcase }
  before_save :create_remember_token


  validates :password,
            :length => { :in => 8..20 },
            :confirmation => true


  validates :password_confirmation, presence: true

  has_many :foods, :dependent => :destroy
  #validates_associated :foods
  has_many :users_recipes, :dependent => :destroy
  has_many :recipes, :through => :users_recipes, :dependent => :destroy
  #validates_associated :recipes
  has_many :users_menus,:dependent => :destroy
  has_many :menus, :through => :users_menus,:dependent => :destroy

  has_many :compositions, :dependent => :destroy
 # validates_associated :menus

  validates :username,
            :length => { :maximum => 15 },
           # :exclusion => { :in => %w(admin superuser administrator root) },
            :uniqueness => true,
            :format => { :with => /\A[a-zA-Z1-9]+\z/ }

  validates :email,
            :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create },
            uniqueness: {case_sensitive: false}


  validates :dateOfBirth, :presence => true


  validates :address, :presence => true

  validates :name, :presence => true,
            :length => { :maximum => 30 },
            :format => { :with => /\A[a-zA-Z]+\z/ }

  validates :surname, :presence => true,
            :format => { :with => /\A[a-zA-Z]+\z/ },
            :length => { :maximum => 30 }

  validates :gender, :presence => true
  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
