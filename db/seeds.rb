User.create!(first_name: "Administrative", last_name: "User", email: "admin@example.com", address_line_1: "101 City Hall Plaza", city: "Durham", zip_code: 27701, password: "foobar", password_confirmation: "foobar", admin: true, activated: true, activated_at: Time.zone.now)

99.times do |n|
  first_name  = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "example-#{n+1}@example.com"
  organization = "Organization #{n}"
  address_line_1 = "#{n} Example Road"
  address_line_2 = "Suite #{n}"
  city = "Durham"
  zip_code = 27701
  password = "password"
  User.create!(first_name: first_name, last_name: last_name, email: email, organization: organization, address_line_1: address_line_1, city: city, zip_code: zip_code, password: password, password_confirmation: password, activated: true, activated_at: Time.zone.now)
end
