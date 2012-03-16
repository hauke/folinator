@slides.each do |slide|
  slide.annotations.each do |annotation|
    pdf.text annotation.annotation, size: 42
  end
  pdf.image slide.image.file,
    :at  => [0, Prawn::Document::PageGeometry::SIZES["A4"][1]],
    :fit => Prawn::Document::PageGeometry::SIZES["A4"]
  pdf.outline.page :title => "#{slide.title ? slide.title.annotation : slide.number}", :destination => slide.number
  pdf.start_new_page unless slide.last?
end
