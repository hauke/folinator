class Slide < ActiveRecord::Base
  belongs_to :slideset
  has_many :annotations
end
