class AddProfileToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile_message, :string
    add_column :users, :job, :string
    add_column :users, :phone_number, :string
  end
end
