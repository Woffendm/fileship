module FoldersHelper

  def breadcrumbs(folder, crumbs='')
    if folder.parent && (@current_user.is_admin? || folder.parent != Folder.root)
      crumbs = breadcrumbs(folder.parent, crumbs) + crumbs + ' / '
    end
    crumbs += "#{link_to folder.name, folder}"
  end

  def file_icon(extension)
    if extension && FileTest.exists?(Rails.root.join('app','assets','images','fileicons', "#{extension.downcase}.png"))
      return image_path("fileicons/#{extension.downcase}.png")
    else
      return image_path('icons/page_white.png')
    end
  end

  def upload_button(folder)
    content_tag :div, '', {
      :data => {
        :'upload-action' => folder_user_files_path(folder, :format => :json),
        :'folder-html-action' => folder_path(folder, :format => :json),
        :'ie-progress-image-src' => image_path('loading.gif')
      }, 
      :id => 'file-uploader'
    }
  end

end
