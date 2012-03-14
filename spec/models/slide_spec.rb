# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: slides
#
#  id          :integer         not null, primary key
#  image       :string(255)
#  slideset_id :integer
#  deleted     :boolean
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  position    :integer
#  title_id    :integer
#

require 'spec_helper'

describe Slide do
  before do
    @lecture = Factory :lecture
    @slideset = Factory :slideset, lecture:  @lecture
    @slideset.save!
    @slide = Slide.new(image: get_image_stream)
  end
  subject { @slide }
  
  describe "slideset:" do
    describe "do not belong to a slideset" do
      it { should_not be_valid }
    end
    describe "belongs to a slideset" do
      before { @slideset.slides << @slide } 
      it { should be_valid }
    end
  end

end
