class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :access_token
      t.string :uuid
      t.string :twitter_id
      t.string :github_id
      t.string :person_id

      t.timestamps
    end
  end
end
