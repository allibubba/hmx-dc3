class ChangeEmailToEncryptedEmailInUsers < ActiveRecord::Migration
  def up
    rename_column :users, :email, :encrypted_email
  end

  def down
    rename_column :users, :encrypted_email, :email
  end
end
