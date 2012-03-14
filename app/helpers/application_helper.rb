# -*- encoding : utf-8 -*-
module ApplicationHelper
  def full_title(page_title)
    base_title = "Folinator"
    if (!page_title.empty?)
      "#{base_title} | #{page_title}"
    else if (@lecture && @slideset && @slide && @slide.title)
      "#{base_title} | #{@lecture.title} | #{@slideset.title} | #{@slide.title.annotation}"
    else if (@lecture && @slideset)
      "#{base_title} | #{@lecture.title} | #{@slideset.title}"
    else if (@lecture)
      "#{base_title} | #{@lecture.title}"
    else
      base_title
    end
    end
    end
    end
  end
end
