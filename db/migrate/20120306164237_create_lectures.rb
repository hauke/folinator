class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :title
      t.boolean :deleted

      t.timestamps
    end
  end
end
