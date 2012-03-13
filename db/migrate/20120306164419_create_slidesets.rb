class CreateSlidesets < ActiveRecord::Migration
  def change
    create_table :slidesets do |t|
      t.string :title
      t.integer :lecture_id
      t.boolean :deleted

      t.timestamps
    end
  end
end
