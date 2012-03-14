# -*- encoding : utf-8 -*-
module SlidesHelper

  def next_slide_link slide
    if slide.lower_item
      link_to 'Next', slideset_slide_path(slide.slideset, slide.lower_item)
    else
      "Next"
    end
  end

  def previous_slide_link slide
    if slide.higher_item
      link_to 'Previous', slideset_slide_path(slide.slideset, slide.higher_item)
    else
      "Previous"
    end
  end

  def first_slide_link slide
    if slide.first?
      "First"
    else
      link_to 'First', slideset_slide_path(slide.slideset, slide.slideset.slides.first)
    end
  end

  def last_slide_link slide
    if slide.last?
      "Last"
    else
      link_to 'Last', slideset_slide_path(slide.slideset, slide.slideset.slides.last)
    end
  end
end
