# == Schema Information
#
# Table name: slides
#
#  id          :integer         not null, primary key
#  image       :string(255)
#  slideset_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe Slide do
  before do
    @slideset = Slideset.new(title:"test")
    @slide = Slide.new(image:"Testslide")
  end
  subject { @slide }
  
  describe "slideset" do
    describe "do not belong to a slideset" do
      it { should_not be_valid }
    end
    describe "belongs to a slideset" do
      before { @slide.slideset = @slideset }
      it { should be_valid }
    end
  end


end
