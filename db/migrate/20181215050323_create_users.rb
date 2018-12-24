class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :access_token
      t.string :uuid
      t.string :twitter_id, default: ''
      t.string :github_id, default: ''
      t.string :person_id, default: ''

      t.timestamps
    end
  end
end
