class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :profile, :text
    add_column :users, :profile_image_path, :string
  end
end
