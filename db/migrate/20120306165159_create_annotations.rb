# -*- encoding : utf-8 -*-
class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.string :annotation, :null => false
      t.references :slide, :null => false
      t.boolean :deleted, null: false, default: false
      t.integer :last_author_id, :null => false

      t.timestamps :null => false
    end
    change_table :annotations do |t|
      t.index :annotation
      t.index :slide_id
      t.index :last_author_id
      t.foreign_key :slides, :dependent => :delete
      t.foreign_key :users, :column => 'last_author_id'
    end
  end
end
