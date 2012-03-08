# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def get_image_stream filename
 File.open("#{Rails.root}/spec/fixtures/#{filename}")
end

slidesets = Slideset.create([
  { title: 'Prozesse' },
  { title: 'Netze' }
])

slides = Slide.create([
  {image: get_image_stream("folie-0001-256-w50k.png"), slideset: slidesets.first},
  {image: get_image_stream("folie-0002-256-w50k.png"), slideset: slidesets.first},
  {image: get_image_stream("folie-0003-256-w50k.png"), slideset: slidesets.first},
  {image: get_image_stream("folie-0005-256-w50k.png"), slideset: slidesets.first},
  {image: get_image_stream("folie-0006-256-w50k.png"), slideset: slidesets.last},
  {image: get_image_stream("folie-0007-256-w50k.png"), slideset: slidesets.last},
  {image: get_image_stream("folie-0008-256-w50k.png"), slideset: slidesets.last}
])

annotations = Annotation.create([
  {annotation: "TCP", slide: slides[0]},
  {annotation: "IP", slide: slides[0]},
  {annotation: "IP", slide: slides[1]},
  {annotation: "UDP", slide: slides[1]},
  {annotation: "Sicherheit", slide: slides[2]},
  {annotation: "Sicherheit", slide: slides[3]},
  {annotation: "Sicherheit", slide: slides[6]},
  {annotation: "IP", slide: slides[6]}
])
