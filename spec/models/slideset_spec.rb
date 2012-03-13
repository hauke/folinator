# == Schema Information
#
# Table name: slidesets
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  lecture_id  :integer
#  deleted     :boolean
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  description :text
#

require 'spec_helper'

describe Slideset do
  before do	
    @lecture = Factory :lecture
    @slideset= Factory :slideset, lecture: @lecture
  end
  subject { @slideset }
  
  describe "can create slides" do
   before { @slideset.save }   
   it "should create slides" do
     expect { @slideset.slides.create(image: get_image_stream) }.to change(Slide, :count).by(1)
   end
  end
end
