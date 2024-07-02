class User < ApplicationRecord
  has_many :rooms
  has_many :reservations, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  mount_uploader :user_image, UserimageUploader

end