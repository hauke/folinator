# -*- encoding : utf-8 -*-
class AddPositionToSlides < ActiveRecord::Migration
  def change
    add_column :slides, :position, :integer

  end
end
