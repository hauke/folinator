class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :title

      t.timestamps
    end
  end
end
