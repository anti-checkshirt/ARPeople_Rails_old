class AddUserToAge < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :age, default: ''
  end
end
