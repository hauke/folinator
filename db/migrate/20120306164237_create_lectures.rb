# -*- encoding : utf-8 -*-
class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :title, :null => false
      t.boolean :deleted, null: false, default: false

      t.timestamps :null => false
    end
    change_table :lectures do |t|
      t.index [:deleted, :title]
    end
  end
end
