class CreateUsers < ActiveRecord::Migration
  def change
    #drop_table :users
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :surname
      t.string :password_digest
      t.string :address
      t.integer :rank
      t.date :dateOfBirth
      t.string :email
      t.timestamps
    end
  end
end
