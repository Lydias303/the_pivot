class User < ActiveRecord::Base
  has_secure_password
  has_many :listings
  validates :first_name, :last_name, :display_name, :about_me, presence: true
  validates :display_name, format: { with: /\A[a-zA-Z]+\z/ }
  validates :display_name, :slug, uniqueness: true
  validates :email,
            format: {
              with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
            }, uniqueness: true
  has_many :listings
  has_many :listing_images, :through => :listings
  has_many :orders
<<<<<<< HEAD
  has_attached_file :image, styles: { medium: "300x300>",
                                      thumb: "100x100>" },
                                      default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
=======

  mount_uploader :image, UserUploader
>>>>>>> 001e874480cccf1b3d8889c9a8df87340b60f2a0

  before_save :generate_slug

  enum role: [:default, :host]

  def generate_slug
    self.slug = display_name.parameterize
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    false
  end
end
