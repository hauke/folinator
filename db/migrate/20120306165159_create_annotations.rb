class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.string :annotation
      t.integer :slide_id

      t.timestamps
    end
  end
end
