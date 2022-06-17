# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create(email: 'user@example.com', nickname: 'UOne', name: 'User One', password: "monkey67")
Parentcategory.create!([
  {name: 'Blues',tag: 'blues' },
  {name: 'Classical',tag: 'classical' },
  {name: 'Rock',tag: 'rock' },
  {name: 'Ambient',tag: 'ambient' },
  {name: 'Breakbeat',tag: 'breakbeat' },
  {name: 'Disco',tag: 'disco' },
  {name: 'Downtempo',tag: 'downtempo' },
  {name: 'House',tag: 'house' },
  {name: 'Techno',tag: 'techno' },
  {name: 'Trance music',tag: 'trance' },
  {name: 'Folk',tag: 'folk' },
  {name: 'Jazz',tag: 'jazz' },
]);


Artfield.create!([
  {name: 'Music',tag: 'music' },
  {name: 'Photography',tag: 'photography' },
  {name: 'Film',tag: 'Film' },
  {name: 'Painting',tag: 'painting' },
  {name: 'Design',tag: 'design' },
  {name: 'Digital art',tag: 'digital-art' },
  {name: 'Decorative arts',tag: 'decorative-arts' },
  {name: 'Sculpture',tag: 'sculpture' },
  {name: 'Printmaking',tag: 'printmaking' },
  {name: 'Collagec',tag: 'collage' }
]);
