# -*- encoding : utf-8 -*-
class CreateSlidesets < ActiveRecord::Migration
  def change
    create_table :slidesets do |t|
      t.string :title, :null => false
      t.references :lecture, :null => false
      t.boolean :deleted, null: false, default: false
      t.text :description

      t.timestamps :null => false
    end
    change_table :slidesets do |t|
      t.index [:lecture_id, :deleted, :title]
      t.foreign_key :lectures, :dependent => :delete
    end
  end
end
