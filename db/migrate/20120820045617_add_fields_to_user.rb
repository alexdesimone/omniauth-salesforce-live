class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    add_column :users, :instance_url, :string
  end
end
