class AddAdminColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_admin, :boolean,:default=> false
    User.first.update(:is_admin=>true)
  end
end
