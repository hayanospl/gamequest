class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false, default: "", unique: true
    add_column :users, :profile, :text
    # add_column :users, :profile_image_path, :string
    add_column :users, :uid, :string
    add_column :users, :provider, :string
  end
end
