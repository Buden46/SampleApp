class CreateUserTable < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.text :hobbies
      t.string :address
      t.timestamps
    end
  end
end
