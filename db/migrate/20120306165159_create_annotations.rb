# -*- encoding : utf-8 -*-
class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.string :annotation
      t.integer :slide_id
      t.boolean :deleted, null: false, default: false
      t.integer :last_author_id

      t.timestamps
    end
  end
end
