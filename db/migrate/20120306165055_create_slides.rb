class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :filepath
      t.integer :slideset_id

      t.timestamps
    end
  end
end
