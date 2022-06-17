desc 'Add artcategory'
task :add_artcategory => :environment do
  artcategory = Artcategory.create(name: 'Marketing')
  childs = ['Viral marketing', 'Public relations strategies', 'Convention concepts', 'Event concepts', 'Brand awareness strategies',
            'Brand concepts', 'Targeting strategies', 'Tracking strategies']

  childs.each { |child| artcategory.subcategories.create(name: child) }
end
