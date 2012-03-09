class AddTitleAnnotationToSlides < ActiveRecord::Migration
  def change
    add_column :slides, :title_id, :integer

  end
end
