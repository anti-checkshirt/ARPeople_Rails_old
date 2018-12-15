class AddUserToUserImageUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_image_url,:string,default: ''
  end
end
