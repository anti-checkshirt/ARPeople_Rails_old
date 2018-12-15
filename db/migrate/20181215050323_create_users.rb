class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :Twitter_ID, default: ''
      t.string :Github_ID, default: ''
      t.string :Person_ID, default: ''

      t.timestamps
    end
  end
end
