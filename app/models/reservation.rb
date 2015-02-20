class Reservation < ActiveRecord::Base
  validates :user_id, presence: true
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user
  scope :ordered, -> { where(status: "ordered") }
  scope :completed, -> { where(status: "completed") }
  scope :paid, -> { where(status: "paid") }
  scope :cancelled, -> { where(status: "cancelled") }

  def guest
    user
  end

  def host
    user
  end

  def create_line_items(cart_items)
    cart_items.map do |item_id, quantity|
      LineItem.create(item_id: item_id.to_i, quantity: quantity)
    end
  end

  def total(line_items)
    line_items.map do |line_item|
      (line_item.quantity * line_item.item.price) / 100
    end.reduce(:+)
  end

  def format_reservation_number(reservation_id)
    reservation_id.to_s.rjust(5, "0")
  end

  def formatted_created_at
    created_at.strftime("%m/%d/%Y at: %I:%M %p")
  end

  def find_user_info(user_id)
    User.find(user_id)
  end


end
