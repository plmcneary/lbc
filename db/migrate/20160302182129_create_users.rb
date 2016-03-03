class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :organization
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.integer :zip_code
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
