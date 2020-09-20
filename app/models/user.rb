class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_uniqueness_of :username
  validates :username, format: { with: /\A(?=.*[a-z])[a-z\d]+\Z/i, message: "only allows letters and numbers" }


  def admin?
    self.admin == true
  end
end
