# == Schema Information
#
# Table name: slidesets
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  lecture_id  :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  description :text
#

require 'spec_helper'

describe Slideset do
  before do	
    @slideset= Slideset.new(title:"Testset")
  end
  subject { @slideset }
  
  describe "can create slides" do
   before { @slideset.save }   
   it "should create slides" do
     expect { @slideset.slides.create(image: get_image_stream) }.to change(Slide, :count).by(1)
   end
  end
end
