# -*- encoding : utf-8 -*-
module SlidesHelper

  def next_slide_link slide
    if slide.lower_item
      link_to 'Vor', slideset_slide_path(slide.slideset, slide.lower_item), accesskey: "V"
    else
      "Vor"
    end
  end

  def previous_slide_link slide
    if slide.higher_item
      link_to 'Zurück', slideset_slide_path(slide.slideset, slide.higher_item), accesskey: "Z"
    else
      "Zurück"
    end
  end

  def first_slide_link slide
    if slide.first?
      "Anfang"
    else
      link_to 'Anfang', slideset_slide_path(slide.slideset, slide.slideset.slides.first)
    end
  end

  def last_slide_link slide
    if slide.last?
      "Ende"
    else
      link_to 'Ende', slideset_slide_path(slide.slideset, slide.slideset.slides.last)
    end
  end
end
