# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def get_image_stream
 File.open("#{Rails.root}/spec/fixtures/folie-0001-256-w50k.png")
end

slidesets = Slideset.create([{ title: 'Prozesse' }, { title: 'Netz' }])
slides = Slide.create([{image: get_image_stream, slideset: slidesets.first}, {image: get_image_stream, slideset: slidesets.first}, {image: get_image_stream, slideset: slidesets.first}, {image: get_image_stream, slideset: slidesets.last}, {image: get_image_stream, slideset: slidesets.last}])
