# -*- encoding : utf-8 -*-
class AddDescriptionToSlideset < ActiveRecord::Migration
  def change
    add_column :slidesets, :description, :text

  end
end
