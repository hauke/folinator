# -*- encoding : utf-8 -*-
class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.openid_authenticatable
      t.string :email
      t.string :name
      t.boolean :admin


      t.timestamps
    end

    add_index :users, :identity_url, :unique => true
  end

end

