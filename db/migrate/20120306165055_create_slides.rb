# -*- encoding : utf-8 -*-
class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :image, :null => false
      t.references :slideset, :null => false
      t.boolean :deleted, null: false, default: false
      t.integer :number
      t.integer :position, :null => false
      t.integer :title_id

      t.timestamps :null => false
    end
    change_table :slides do |t|
      t.index :position
      t.index :title_id
      t.index :slideset_id
      t.foreign_key :slidesets, :dependent => :delete
      t.foreign_key :annotations, :column => 'title_id'
    end
  end
end
