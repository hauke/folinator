# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: annotations
#
#  id             :integer         not null, primary key
#  annotation     :string(255)
#  slide_id       :integer
#  deleted        :boolean
#  last_author_id :integer
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

require 'spec_helper'

describe Annotation do
  before do
    @lecture = Factory :lecture
    @slideset = Factory :slideset, lecture: @lecture
    @slideset.save!
    @slide = Slide.new(image: get_image_stream)
    @slide.slideset = @slideset
    @slide.save!
    @annotation = Annotation.new(annotation:"this is a test")
  end
  subject { @annotation }
  
  describe "slide:" do
    describe "do not belong to a slide" do
      it { should_not be_valid }
    end
    describe "belongs to a slide" do
      before { @annotation.slide = @slide }
      it { should be_valid }
    end
  end
end
