class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :Twitter_ID
      t.string :Github_ID

      t.timestamps
    end
  end
end
