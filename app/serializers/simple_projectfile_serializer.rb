class SimpleProjectfileSerializer < ActiveModel::Serializer
  attributes :id, :showinfo, :filedescription, :handle, :project_id, :mimetype, :url, :width, :height, :preview, :kind, :thumb, :feedformat, :projectfile_title


    def projectfile_title
      if object.name
        object.name
      else
        "Untitled"
      end
    end

  def id
    object.id.to_s
  end

  def feedformat

    format = "item-media-view--square"

    if (!object.width || !object.height)
      return format
    end

    if (object.width != 0 && object.height != 0) && (object.width / object.height) == 1
      format = "item-media-view--horizontal"
    elsif  object.width == object.height && object.width != 0 && object.height != 0
      format = "item-media-view--square"
    elsif (object.width != 0 && object.height != 0) && (object.width / object.height) == 0
      format = "item-media-view--vertical"
    else
      format = "item-media-view--video"
    end

    if object.mimetype.match? 'audio'
      format = "item-media-view--horizontal"
    end

    return format

  end

  def ww

    format = "300"

    if (!object.width || !object.height)
      return format
    end

    if (object.width != 0 && object.height != 0) && (object.width / object.height) == 1
      format = "300"
    elsif  object.width == object.height && object.width != 0 && object.height != 0
      format = "400"
    elsif (object.width != 0 && object.height != 0) && (object.width / object.height) == 0
      format = "150"
    else
      format = "400"
    end


    return format

  end

  def hh

    format = "150"

    if (!object.width || !object.height)
      return format
    end

    if (object.width != 0 && object.height != 0) && (object.width / object.height) == 1
      format = "150"
    elsif  object.width == object.height && object.width != 0 && object.height != 0
      format = "400"
    elsif (object.width != 0 && object.height != 0) && (object.width / object.height) == 0
      format = "300"
    else
      format = "400"
    end


    return format

  end


  def kind
    if object.mimetype.match? 'image'
      return 'image'
    elsif object.mimetype == 'video/youtube'
      return 'hostedvideo'
    elsif object.mimetype == 'video/vimeo'
      return 'hostedvideo'
    elsif object.mimetype.match? 'video'
      return 'video'

    else
      return 'audio'
    end
  end
  def thumb
    if object.mimetype.match? 'image'
      return 'https://cdn.filestackcontent.com/output=format:pjpg/rotate=deg:"exif"/resize=height:200/auto_image/compress/security=p:eyJleHBpcnkiOjE2MDE1MDMyMDB9,s:bc4a824e413e3b95c04a35ceaa0f62aa96a4b97ad7237807dd591a402893803a/'+object.handle
    elsif (object.mimetype.match? 'video' || 'audio')
      if object.avconversion
        return object.avconversion.thumb
      else
        return ""
      end
    end
  end

  def preview
    if object.mimetype.match? 'image'
      return 'https://cdn.filestackcontent.com/rotate=deg:"exif"/resize=height:600/auto_image/compress/security=p:eyJleHBpcnkiOjE2MDE1MDMyMDB9,s:bc4a824e413e3b95c04a35ceaa0f62aa96a4b97ad7237807dd591a402893803a/'+object.handle
    else
    end
  end

  def grid_preview
    if object.mimetype.match? 'image'


      format = "width:600,height:600"

      if (!object.width || !object.height)
          return format
      end

      if (object.width != 0 && object.height != 0) && (object.width / object.height) == 1
        format = "width:600,height:300"
      elsif  object.width == object.height && object.width != 0 && object.height != 0
        format = "width:600,height:600"
      elsif (object.width != 0 && object.height != 0) && (object.width / object.height) == 0
        format = "width:300,height:600"
      else
        format = "width:600,height:600"
      end


      return 'https://cdn.filestackcontent.com/rotate=deg:"exif"/resize=' + format + ',fit:crop/auto_image/compress/security=p:eyJleHBpcnkiOjE2MDE1MDMyMDB9,s:bc4a824e413e3b95c04a35ceaa0f62aa96a4b97ad7237807dd591a402893803a/'+object.handle
    else
    end
  end

end
