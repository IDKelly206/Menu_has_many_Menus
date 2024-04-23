module ApplicationHelper
  # Returns the full title on a per-page basis
  def title(page_title)
    content_for(:title) { page_title }
  end


end
