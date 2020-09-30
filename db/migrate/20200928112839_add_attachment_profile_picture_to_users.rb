class AddAttachmentProfilePictureToUsers < ActiveRecord::Migration[6.0]
  def change
    add_attachment :users, :profile_picture
  end
end