class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

#Organization

  validates :organization, length: { maximum: 100 }, uniqueness: { case_sensitive: false }

# Address

  validates :address_line_1, presence: true, length: { maximum: 100 }
  validates :address_line_2, length: { maximum: 100 }
  VALID_CITIES_REGEX = /\A(?:(Durham)|(Chapel Hill)|(Hillsborough))\z/
  validates :city, presence: true, format: { with: VALID_CITIES_REGEX }
  VALID_ZIP_CODE_REGEX = /\A(?:(27278)|(27510)|(27514)|(27516)|(27517)|(27599)|(27701)|(27703)|(27704)|(27705)|(27706)|(27707)|(27708)|(27709)|(27710)|(27711)|(27712)|(27713))\z/
  validates :zip_code, presence: true, format: { with: VALID_ZIP_CODE_REGEX }
end
