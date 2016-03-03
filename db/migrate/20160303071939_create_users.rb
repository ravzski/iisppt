class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :bank_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :encrypted_password
      t.string :access_token
      t.string :role
      t.boolean :super_admin
      t.boolean :is_active, default: true
      t.timestamps null: false
    end

  end
end
