class SimpleuserSerializer < ActiveModel::Serializer
  attributes :profileimage, :sharetoken, :showtutorials, :id, :name, :email, :imagethumb, :image


  def imagethumb
    if object.image
      return 'https://cdn.filestackcontent.com/output=format:pjpg/rotate=deg:"exif"/resize=height:160/security=p:eyJleHBpcnkiOjE2MDE1MDMyMDB9,s:bc4a824e413e3b95c04a35ceaa0f62aa96a4b97ad7237807dd591a402893803a/'+object.image

    end
  end

end
