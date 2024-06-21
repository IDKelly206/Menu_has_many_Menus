module NavigationHelper
  def active_page(attr = {})
    path = attr[:path]
    name = attr[:class_name]

    name if current_page?(path)
    
    # below won't work b/c root_path included in all
    # name if request.url.include?(path)
  end
end
