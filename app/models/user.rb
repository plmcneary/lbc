class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token
  before_save { email.downcase! }
  before_create :create_activation_digest
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

#Organization

  validates :organization, length: { maximum: 100 }, allow_nil: true

# Address

  validates :address_line_1, presence: true, length: { maximum: 100 }
  validates :address_line_2, length: { maximum: 100 }
  VALID_CITIES_REGEX = /\A(?:(Durham)|(Chapel Hill)|(Hillsborough))\z/
  validates :city, presence: true, format: { with: VALID_CITIES_REGEX }
  VALID_ZIP_CODE_REGEX = /\A(?:(27278)|(27510)|(27514)|(27516)|(27517)|(27599)|(27701)|(27703)|(27704)|(27705)|(27706)|(27707)|(27708)|(27709)|(27710)|(27711)|(27712)|(27713))\z/
  validates :zip_code, presence: true, format: { with: VALID_ZIP_CODE_REGEX }

# Secure Password

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
