desc 'Fix artcategory'
task :fix_artcategory => :environment do
  Artcategory.update(36, {name: 'Experimental film'})
  Artcategory.update(301, {parent_id: 18})

  Project.where(artcategory_id: 43).update_all(artcategory_id: 36)
  Project.where(artcategory_id: 136).update_all(artcategory_id: 199)

  Skip.where(artcategory_id: 43).update_all(artcategory_id: nil)
  Skip.where(artcategory_id: 136).update_all(artcategory_id: nil)

  Artcategory.find(43).delete
  Artcategory.find(136).delete

  Artrelation.where(fromcategory_id: [43, 136]).delete_all
end
