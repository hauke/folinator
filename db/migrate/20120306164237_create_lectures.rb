# -*- encoding : utf-8 -*-
class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :title
      t.boolean :deleted, null: false, default: false

      t.timestamps
    end
  end
end
