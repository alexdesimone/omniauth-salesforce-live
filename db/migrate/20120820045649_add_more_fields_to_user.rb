class AddMoreFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :location, :string
    add_column :users, :phone, :string
    add_column :users, :owner_id, :string
  end
end
