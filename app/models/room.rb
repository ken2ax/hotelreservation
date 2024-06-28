class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy

  mount_uploader :room_image, ImageUploader

  def self.search(search)
    return Room.all  unless search
    if search == "京都"
      Room.where('address LIKE(?)', "#{search}%")
    else
      Room.where('address LIKE(?)', "%#{search}%")
    end
  end

  def self.areasearch(search)
    return Room.all  unless search
    if search == "京都"
      Room.where('address LIKE(?)', "#{search}%")
    else
      Room.where('address LIKE(?)', "%#{search}%")
    end
  end

  with_options presence: true do
    validates :name
    validates :detail
    validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 1 }, length: { maximum: 15 }
    validates :address
    validates :user_id
  end

end
