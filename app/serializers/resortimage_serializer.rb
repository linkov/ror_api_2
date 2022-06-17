class ResortimageSerializer < ActiveModel::Serializer
  attributes :id, :order, :projectfile_id, :projectresort_id, :thumb, :kind

  def kind
    file = Projectfile.find(object.projectfile_id)
    if file.mimetype.match? 'image'
      return 'image'
    elsif file.mimetype == 'video/youtube'
      return 'hostedvideo'
    elsif file.mimetype == 'video/vimeo'
      return 'hostedvideo'
    elsif file.mimetype.match? 'video'
      return 'video'

    else
      return 'audio'
    end
  end

  def thumb
    file = Projectfile.find(object.projectfile_id)
    if file.mimetype.match? 'image'
      return 'https://cdn.filestackcontent.com/output=format:pjpg/rotate=deg:"exif"/resize=height:200/auto_image/compress/security=p:eyJleHBpcnkiOjE2MDE1MDMyMDB9,s:bc4a824e413e3b95c04a35ceaa0f62aa96a4b97ad7237807dd591a402893803a/'+file.handle
    elsif (file.mimetype.match? 'video' || 'audio')
      if file.conversionjobid && file.conversionjobid.length && Avconversion.where(:jobid =>file.conversionjobid ).length > 0
        return Avconversion.where(:jobid =>object.conversionjobid ).first.thumb
      else

        if file.mimetype.match? 'video'
            return 'assets/newsfeed/mediatype-video.png'
        else
            return 'assets/newsfeed/mediatype-sound.png'
        end


      end
    end
  end
end
