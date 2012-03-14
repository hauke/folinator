# -*- encoding : utf-8 -*-
class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :image
      t.integer :slideset_id
      t.boolean :deleted, null: false, default: false

      t.timestamps
    end
  end
end
