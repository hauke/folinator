# -*- encoding : utf-8 -*-
class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.openid_authenticatable
      t.string :email
      t.string :name
      t.boolean :admin, :null => false, :default => false
      t.boolean :banned, :null => false, :default => false

      t.timestamps :null => false
    end

    add_index :users, :identity_url, :unique => true
  end

end

