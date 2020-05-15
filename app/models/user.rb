class User < ApplicationRecord
  has_secure_password
  before_validation { email.downcase! }
  before_destroy :check_destroy
  before_update :check_update

  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy


  validates :password, presence: true, length: { minimum: 6 }
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true

  private

  def check_destroy
    throw :abort if User.where(admin: true).count == 1 && admin == true
  end

  def check_update
    throw :abort if User.where(admin: true).count == 1 && admin == false
  end
end
